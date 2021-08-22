package com.example.restaurantbackend.repository;

import com.example.restaurantbackend.model.ImageFile;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;

@Repository
@Transactional
public interface ImageFileRepository extends JpaRepository<ImageFile, Long> {

}
