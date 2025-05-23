package com.assessment.ecommerce.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "product_discounts")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductDiscount {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer productDiscountId;

    @ManyToOne
    @JoinColumn(name = "product_id", nullable = false)
    private Product product;

    private BigDecimal discountPercent;

    private LocalDate validFrom;

    private LocalDate validTo;

    @CreationTimestamp
    private LocalDateTime createdAt;

    @UpdateTimestamp
    private LocalDateTime updatedAt;
}