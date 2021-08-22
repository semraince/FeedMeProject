package com.example.restaurantbackend.repository;

import com.example.restaurantbackend.model.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import javax.transaction.Transactional;

@Repository
@Transactional
public interface OrderRepository extends JpaRepository<Order, Long> {
    @Modifying
    @Query("delete from Order u where u.id = ?1")
    void deleteOrderItemById(Long id);
}
