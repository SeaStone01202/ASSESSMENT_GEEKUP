package com.assessment.ecommerce.dto.response;

import lombok.*;

import java.math.BigDecimal;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductResponse {
    private Long productId;
    private String name;
    private BigDecimal basePrice;
    private String gender;

    private String categoryName;
    private String brandName;

    private List<ProductImageResponse> images;
}