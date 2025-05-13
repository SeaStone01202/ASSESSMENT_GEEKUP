package com.assessment.ecommerce.dto.mapper;

import com.assessment.ecommerce.dto.response.ProductResponse;
import com.assessment.ecommerce.entity.Product;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface ProductMapper {
    @Mapping(source = "category.name", target = "categoryName")
    @Mapping(source = "brand.name", target = "brandName")
    ProductResponse toResponse(Product product);
}
