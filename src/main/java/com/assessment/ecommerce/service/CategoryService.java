package com.assessment.ecommerce.service;

import com.assessment.ecommerce.dto.response.CategoryResponse;

import java.util.List;

public interface CategoryService {
    List<CategoryResponse> getCategories();
}
