package com.assessment.ecommerce.service.impl;

import com.assessment.ecommerce.dto.mapper.CategoryMapper;
import com.assessment.ecommerce.dto.response.CategoryResponse;
import com.assessment.ecommerce.repository.CategoryRepository;
import com.assessment.ecommerce.service.CategoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CategoryServiceImpl implements CategoryService {

    private final CategoryRepository categoryRepository;

    private final CategoryMapper categoryMapper;

    @Override
    @Transactional(readOnly = true)
    public List<CategoryResponse> getCategories() {
        return categoryRepository.findAll().stream().map(categoryMapper::toResponse).toList();
    }
}
