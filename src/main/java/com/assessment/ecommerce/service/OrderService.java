package com.assessment.ecommerce.service;

import com.assessment.ecommerce.dto.request.OrderRequest;
import com.assessment.ecommerce.dto.response.OrderResponse;

public interface OrderService {
    OrderResponse createOrder(OrderRequest request);
}
