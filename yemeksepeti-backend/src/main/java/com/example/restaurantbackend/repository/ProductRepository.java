package com.example.restaurantbackend.repository;


import com.example.restaurantbackend.model.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.annotation.PreDestroy;
import javax.transaction.Transactional;
import java.util.List;

@Repository
@Transactional
public interface ProductRepository extends JpaRepository<Product, Long> {
    List<Product> findByNameContainingOrderById(String name);

    @Query("select p from Product p inner join p.restaurant r where r.id IN (:id) and (lower(p.name) like %:name% or lower(p.ingredients) like %:name2%) ")
    List<Product> findByNameContainingAndRestaurant(@Param("name") String name, @Param("name2") String name2, @Param("id") List<Long> restaurantId);
}
