package com.assessment.ecommerce.service;

import com.assessment.ecommerce.entity.Order;

public interface EmailService {
    void sendOrderConfirmationEmail(String toEmail, Order order);
}
