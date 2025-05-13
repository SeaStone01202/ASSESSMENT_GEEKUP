package com.assessment.ecommerce.dto.response;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductImageResponse {
    private Long imageId;
    private String imageUrl;
    private Boolean isMain;
}