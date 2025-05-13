package com.assessment.ecommerce.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Table(name = "category_discounts")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CategoryDiscount {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer categoryDiscountId;

    @ManyToOne
    @JoinColumn(name = "category_id", nullable = false)
    private Category category;

    private BigDecimal discountPercent;

    private LocalDate validFrom;

    private LocalDate validTo;
}