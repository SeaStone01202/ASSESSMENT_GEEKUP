package com.assessment.ecommerce.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Entity
@Table(name = "housing_types")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class HousingType {
    @Id
    private Integer housingTypeId;

    @Column(nullable = false)
    private String name;

    @OneToMany(mappedBy = "housingType")
    private List<Address> addresses;
}