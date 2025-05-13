package com.assessment.ecommerce.dto.request;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class ProductSearchRequest {
    private String search;
    private Integer brandId;
    private Integer categoryId;
    private BigDecimal minPrice;
    private BigDecimal maxPrice;
}