package com.assessment.ecommerce.dto.mapper;

import com.assessment.ecommerce.dto.response.OrderResponse;
import com.assessment.ecommerce.entity.Order;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface OrderMapper {
    @Mapping(target = "items", source = "orderDetails")
    @Mapping(target = "userId", source = "user.userId")
    @Mapping(target = "addressId", source = "address.addressId")
    OrderResponse toResponse(Order order);
}