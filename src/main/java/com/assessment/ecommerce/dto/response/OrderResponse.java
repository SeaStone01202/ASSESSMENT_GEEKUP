package com.assessment.ecommerce.dto.response;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Data
public class OrderResponse {
    private Integer orderId;
    private Integer userId;
    private Integer addressId;
    private LocalDateTime orderDate;
    private String paymentMethod;
    private BigDecimal totalAmount;
    private String status;
    private List<OrderItemResponse> items;

    @Data
    public static class OrderItemResponse {
        private Integer variantId;
        private Integer storeId;
        private Integer quantity;
        private BigDecimal unitPrice;
    }
}
