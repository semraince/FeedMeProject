package com.example.restaurantbackend.repository;

import com.example.restaurantbackend.model.OrderItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import javax.transaction.Transactional;

@Repository
@Transactional
public interface OrderItemRepository extends JpaRepository<OrderItem, Long> {

}
