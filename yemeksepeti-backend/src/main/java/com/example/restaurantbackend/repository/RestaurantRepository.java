package com.example.restaurantbackend.repository;

import com.example.restaurantbackend.model.Restaurant;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;

@Repository
@Transactional
public interface RestaurantRepository extends JpaRepository<Restaurant, Long> {
    @Override
    Page<Restaurant> findAll(Pageable pageable);

    Page<Restaurant> findByNameContaining(String name, Pageable pageable);

    Page<Restaurant> findByRestaurantType_Id(long id, Pageable pageable);

    @Query(value = "select distinct r from Restaurant r left join r.products m  inner join r.restaurantType t where LOWER(m.name) like %:name% or lower(m.ingredients) like %:name2% or" +
            " lower(r.name) like %:name3% or lower(t.name) like %:name4%",
            countQuery = "select count(distinct r) from Restaurant r left join r.products m inner join r.restaurantType t  where LOWER(m.name) like %:name% or lower(m.ingredients) like %:name2% " +
                    "or lower(r.name) like %:name3 or lower(t.name) like %:name4%")
    Page<Restaurant> findByRestaurantsNameOrProductNameOrProductIngredients(@Param("name") String name, @Param("name2") String name2, @Param("name3") String name3, @Param("name4") String name4, Pageable pageable);
}
