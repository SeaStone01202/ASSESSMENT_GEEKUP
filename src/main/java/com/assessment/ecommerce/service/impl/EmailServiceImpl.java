package com.assessment.ecommerce.service.impl;

import com.assessment.ecommerce.entity.Order;
import com.assessment.ecommerce.entity.OrderDetail;
import com.assessment.ecommerce.service.EmailService;
import lombok.RequiredArgsConstructor;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.text.NumberFormat;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

@Service
@RequiredArgsConstructor
public class EmailServiceImpl implements EmailService {

    private final JavaMailSender mailSender;

    @Override
    @Async
    public void sendOrderConfirmationEmail(String toEmail, Order order) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(toEmail);
        message.setSubject("Xác Nhận Đơn Hàng #" + order.getOrderId());
        message.setText(buildEmailContent(order));
        mailSender.send(message);
    }

    private String buildEmailContent(Order order) {
        NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");

        StringBuilder content = new StringBuilder();
        content.append("Kính gửi Quý Khách,\n\n");
        content.append("Cảm ơn bạn đã đặt hàng tại cửa hàng của chúng tôi! Dưới đây là thông tin chi tiết đơn hàng của bạn:\n\n");
        content.append("Mã Đơn Hàng: #").append(order.getOrderId()).append("\n");
        content.append("Ngày Đặt Hàng: ").append(order.getOrderDate().format(dateFormatter)).append("\n");
        content.append("Phương Thức Thanh Toán: ").append(order.getPaymentMethod()).append("\n");
        content.append("Trạng Thái: ").append(order.getStatus()).append("\n\n");
        content.append("Chi Tiết Đơn Hàng:\n");
        content.append("----------------------------------------\n");

        for (OrderDetail detail : order.getOrderDetails()) {
            content.append("Sản Phẩm: ")
                    .append(detail.getVariant().getProduct().getName())
                    .append(" (Màu: ").append(detail.getVariant().getColor())
                    .append(", Kích Cỡ: ").append(detail.getVariant().getSize()).append(")\n");
            content.append("Số Lượng: ").append(detail.getQuantity()).append("\n");
            content.append("Đơn Giá: ").append(currencyFormat.format(detail.getUnitPrice())).append("\n");
            content.append("----------------------------------------\n");
        }

        content.append("Tổng Tiền: ").append(currencyFormat.format(order.getTotalAmount())).append("\n\n");
        content.append("Chúng tôi sẽ xử lý đơn hàng của bạn sớm nhất có thể. Nếu bạn có bất kỳ câu hỏi nào, vui lòng liên hệ với chúng tôi qua email hoặc số điện thoại.\n\n");
        content.append("Trân trọng,\n");
        content.append("Đội Ngũ Bán Hàng");

        return content.toString();
    }
}