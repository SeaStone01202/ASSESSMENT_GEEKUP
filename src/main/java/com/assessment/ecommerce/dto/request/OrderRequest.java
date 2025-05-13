package com.assessment.ecommerce.dto.request;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

@Data
public class OrderRequest {
    @NotNull(message = "ID người dùng là bắt buộc")
    @Positive(message = "ID người dùng phải là số dương")
    private Integer userId;

    @NotNull(message = "ID địa chỉ là bắt buộc")
    @Positive(message = "ID địa chỉ phải là số dương")
    private Integer addressId;

    @NotNull(message = "Phương thức thanh toán là bắt buộc")
    private String paymentMethod;

    private String voucherCode;

    @NotEmpty(message = "Danh sách chi tiết đơn hàng không được để trống")
    private List<OrderItemRequest> items;

    @Data
    public static class OrderItemRequest {
        @NotNull(message = "ID biến thể sản phẩm là bắt buộc")
        @Positive(message = "ID biến thể sản phẩm phải là số dương")
        private Integer variantId;

        @NotNull(message = "ID cửa hàng là bắt buộc")
        @Positive(message = "ID cửa hàng phải là số dương")
        private Integer storeId;

        @NotNull(message = "Số lượng là bắt buộc")
        @Positive(message = "Số lượng phải là số dương")
        private Integer quantity;

        @NotNull(message = "Đơn giá là bắt buộc")
        @Positive(message = "Đơn giá phải là số dương")
        private BigDecimal unitPrice;
    }
}
