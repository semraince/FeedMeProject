package com.example.restaurantbackend.repository;

import com.example.restaurantbackend.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import javax.transaction.Transactional;

@Repository
@Transactional
public interface UserRepository extends JpaRepository<User, Long> {

    public User getUserByUserId(String userId);

}
