package com.example.restaurantbackend.repository;

import com.example.restaurantbackend.model.Address;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import javax.transaction.Transactional;
import java.util.List;

@Repository
@Transactional
public interface AddressRepository extends JpaRepository<Address, Long> {
    @Query("select a from Address a inner join a.user u where u.id = :userId and a.isActive = true")
     Address getActiveAddressByUserId(long userId);

    @Query("select a from Address a inner join a.user u where u.id = :userId order by a.id desc")
     List<Address> getAddressesByUserOrderById(long userId);
}