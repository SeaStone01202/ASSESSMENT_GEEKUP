package com.assessment.ecommerce.service;

import com.assessment.ecommerce.dto.request.ProductSearchRequest;
import com.assessment.ecommerce.dto.response.ProductResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface ProductService {
    Page<ProductResponse> getProductsByCategoryId(String categoryId, Pageable pageable);
    Page<ProductResponse> searchProducts(ProductSearchRequest request, Pageable pageable);
}
