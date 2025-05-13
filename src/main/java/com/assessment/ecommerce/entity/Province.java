package com.assessment.ecommerce.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Entity
@Table(name = "provinces")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Province {
    @Id
    private Integer provinceId;

    @Column(nullable = false)
    private String name;

    @OneToMany(mappedBy = "province")
    private List<District> districts;
}