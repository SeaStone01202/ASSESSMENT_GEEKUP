package com.assessment.ecommerce.service.impl;

import com.assessment.ecommerce.dto.mapper.OrderMapper;
import com.assessment.ecommerce.dto.request.OrderRequest;
import com.assessment.ecommerce.dto.response.OrderResponse;
import com.assessment.ecommerce.entity.*;
import com.assessment.ecommerce.exception.AppException;
import com.assessment.ecommerce.exception.ErrorCode;
import com.assessment.ecommerce.repository.*;
import com.assessment.ecommerce.service.EmailService;
import com.assessment.ecommerce.service.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {

    private final OrderRepository orderRepository;
    private final ProductVariantRepository productVariantRepository;
    private final UserRepository userRepository;
    private final AddressRepository addressRepository;
    private final StoreRepository storeRepository;
    private final OrderMapper orderMapper;
    private final EmailService emailService;

    @Override
    @Transactional
    public OrderResponse createOrder(OrderRequest request) {
        // Validate user
        User user = userRepository.findById(request.getUserId())
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));

        // Validate address
        Address address = addressRepository.findById(request.getAddressId())
                .orElseThrow(() -> new AppException(ErrorCode.ADDRESS_NOT_FOUND));

        // Validate and process order items
        List<OrderDetail> orderDetails = request.getItems().stream().map(itemRequest -> {
            // Validate variant
            ProductVariant variant = productVariantRepository.findById(itemRequest.getVariantId())
                    .orElseThrow(() -> new AppException(ErrorCode.VARIANT_NOT_FOUND));

            // Check stock
            if (variant.getStockQuantity() < itemRequest.getQuantity()) {
                throw new AppException(ErrorCode.INSUFFICIENT_STOCK);
            }

            // Validate store
            Store store = storeRepository.findById(itemRequest.getStoreId())
                    .orElseThrow(() -> new AppException(ErrorCode.STORE_NOT_FOUND));

            // Create order detail
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setVariant(variant);
            orderDetail.setStore(store);
            orderDetail.setQuantity(itemRequest.getQuantity());
            orderDetail.setUnitPrice(itemRequest.getUnitPrice());

            // Update stock
            variant.setStockQuantity(variant.getStockQuantity() - itemRequest.getQuantity());
            productVariantRepository.save(variant);

            return orderDetail;
        }).collect(Collectors.toList());

        // Calculate total amount
        BigDecimal totalAmount = orderDetails.stream()
                .map(item -> item.getUnitPrice().multiply(BigDecimal.valueOf(item.getQuantity())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        // Process payment (simplified for COD)
        if (!"COD".equalsIgnoreCase(request.getPaymentMethod())) {
            throw new AppException(ErrorCode.PAYMENT_METHOD_NOT_SUPPORTED);
        }

        // Create order
        Order order = new Order();
        order.setUser(user);
        order.setAddress(address);
        order.setOrderDate(LocalDateTime.now());
        order.setPaymentMethod(request.getPaymentMethod());
        order.setTotalAmount(totalAmount);
        order.setStatus("PENDING");
        order.setOrderDetails(orderDetails);

        // Link order to details
        orderDetails.forEach(detail -> detail.setOrder(order));

        // Save order
        orderRepository.save(order);

        // Send confirmation email asynchronously
        emailService.sendOrderConfirmationEmail(user.getEmail(), order);

        return orderMapper.toResponse(order);
    }
}