package com.example.restaurantbackend.repository;

import com.example.restaurantbackend.model.Status;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;

@Repository
@Transactional
public interface StatusRepository extends JpaRepository<Status, Long> {
    public Status getStatusByType(String name);

}
