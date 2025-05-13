package com.assessment.ecommerce.service.impl;

import com.assessment.ecommerce.dto.mapper.ProductMapper;
import com.assessment.ecommerce.dto.request.ProductSearchRequest;
import com.assessment.ecommerce.dto.response.ProductResponse;
import com.assessment.ecommerce.entity.Product;
import com.assessment.ecommerce.exception.AppException;
import com.assessment.ecommerce.exception.ErrorCode;
import com.assessment.ecommerce.repository.ProductRepository;
import com.assessment.ecommerce.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService {

    private final ProductRepository productRepository;

    private final ProductMapper productMapper;

    @Override
    @Transactional(readOnly = true)
    public Page<ProductResponse> getProductsByCategoryId(String categoryId, Pageable pageable) {

        if (categoryId == null || categoryId.isEmpty()) {
            throw new AppException(ErrorCode.FIELD_REQUIRED);
        }

        Integer categoryInt = null;
        try {
            categoryInt = Integer.valueOf(categoryId);
        } catch (NumberFormatException e) {
            throw new AppException(ErrorCode.INVALID_FORMAT);
        }

        if (categoryInt <= 0) {
            throw new AppException(ErrorCode.INVALID_FORMAT);
        }

        Page<Product> products = productRepository.findByCategory_CategoryId(categoryInt, pageable);

        if (products.isEmpty()) {
            throw new AppException(ErrorCode.CATEGORY_NOT_EXISTED);
        }

        return products.map(productMapper::toResponse);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<ProductResponse> searchProducts(ProductSearchRequest request, Pageable pageable) {
        Specification<Product> spec = ProductSpecification.buildSearchSpecification(request);
        Page<Product> products = productRepository.findAll(spec, pageable);
        return products.map(productMapper::toResponse);
    }


}
