package com.example.restaurantbackend.repository;

import com.example.restaurantbackend.model.RestaurantType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;

@Repository
@Transactional
public interface RestaurantTypeRepository extends JpaRepository<RestaurantType, Long> {
}
