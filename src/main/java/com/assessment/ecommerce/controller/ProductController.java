package com.assessment.ecommerce.controller;

import com.assessment.ecommerce.dto.ApiResponse;
import com.assessment.ecommerce.dto.request.ProductSearchRequest;
import com.assessment.ecommerce.dto.response.ProductResponse;
import com.assessment.ecommerce.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;

@RestController
@RequestMapping("/api/products")
@RequiredArgsConstructor
public class ProductController {

    private final ProductService productService;

    @GetMapping("/category/{categoryId}")
    public ResponseEntity<ApiResponse<Page<ProductResponse>>> retrieveProductByCategory(
            @PathVariable String categoryId,
            @PageableDefault(page = 0, size = 10, sort = "createdAt", direction = Sort.Direction.DESC) Pageable pageable
    ) {
        return ResponseEntity.ok(ApiResponse.success(productService.getProductsByCategoryId(categoryId, pageable)));
    }

    @GetMapping("/search")
    public ResponseEntity<ApiResponse<Page<ProductResponse>>> searchProducts(
            @RequestParam(required = false) String search,
            @RequestParam(required = false) Integer categoryId,
            @RequestParam(required = false) Integer brandId,
            @RequestParam(required = false) BigDecimal minPrice,
            @RequestParam(required = false) BigDecimal maxPrice,
            @PageableDefault(size = 10, sort = "createdAt", direction = Sort.Direction.DESC) Pageable pageable) {
        if (minPrice != null && maxPrice != null && minPrice.compareTo(maxPrice) > 0) {
            throw new IllegalArgumentException("minPrice phải nhỏ hơn hoặc bằng maxPrice");
        }

        ProductSearchRequest request = new ProductSearchRequest();
        request.setSearch(search);
        request.setCategoryId(categoryId);
        request.setBrandId(brandId);
        request.setMinPrice(minPrice);
        request.setMaxPrice(maxPrice);

        return ResponseEntity.ok(ApiResponse.success(
                productService.searchProducts(request, pageable)
        ));
    }

}
