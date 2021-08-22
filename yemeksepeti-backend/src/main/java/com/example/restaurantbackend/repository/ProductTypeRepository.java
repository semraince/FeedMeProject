package com.example.restaurantbackend.repository;

import com.example.restaurantbackend.model.ProductType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.List;

@Repository
@Transactional
public interface ProductTypeRepository extends JpaRepository<ProductType, Long> {
    List<ProductType> findTop10ByOrderByIdDesc();
}

