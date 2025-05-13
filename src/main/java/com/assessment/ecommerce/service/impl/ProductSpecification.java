package com.assessment.ecommerce.service.impl;

import com.assessment.ecommerce.dto.request.ProductSearchRequest;
import com.assessment.ecommerce.entity.Product;
import jakarta.persistence.criteria.Predicate;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.List;

public class ProductSpecification {
    public static Specification<Product> buildSearchSpecification(ProductSearchRequest req) {
        return (root, query, cb) -> {
            List<Predicate> predicates = new ArrayList<>();

            if (StringUtils.hasText(req.getSearch())) {
                String likePattern = "%" + req.getSearch().toLowerCase() + "%";
                predicates.add(cb.or(
                        cb.like(cb.lower(root.get("name")), likePattern),
                        cb.like(cb.lower(root.get("description")), likePattern)
                ));
            }

            if (req.getBrandId() != null) {
                predicates.add(cb.equal(root.get("brand").get("brandId"), req.getBrandId()));
            }

            if (req.getCategoryId() != null) {
                predicates.add(cb.equal(root.get("category").get("categoryId"), req.getCategoryId()));
            }

            if (req.getMinPrice() != null) {
                predicates.add(cb.greaterThanOrEqualTo(root.get("basePrice"), req.getMinPrice()));
            }

            if (req.getMaxPrice() != null) {
                predicates.add(cb.lessThanOrEqualTo(root.get("basePrice"), req.getMaxPrice()));
            }

            return cb.and(predicates.toArray(new Predicate[0]));
        };
    }
}
