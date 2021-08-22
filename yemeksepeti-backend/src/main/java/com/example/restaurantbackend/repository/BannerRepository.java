package com.example.restaurantbackend.repository;


import com.example.restaurantbackend.model.Banner;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;

@Repository
@Transactional
public interface BannerRepository extends JpaRepository<Banner, Long> {
}
