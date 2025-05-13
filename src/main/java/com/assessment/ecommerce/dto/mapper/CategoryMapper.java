package com.assessment.ecommerce.dto.mapper;

import com.assessment.ecommerce.dto.response.CategoryResponse;
import com.assessment.ecommerce.entity.Category;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface CategoryMapper {
    CategoryResponse toResponse(Category category);
}
