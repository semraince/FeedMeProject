package com.example.restaurantbackend.model;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "restaurants")
public class Restaurant {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    private String name;
    private double speed;
    private double service;
    private double taste;
    private double averageScore;
    private String deliveryTime;
    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "img_id")
    private ImageFile image;
    @OneToMany(mappedBy = "restaurant",
            cascade = CascadeType.ALL,
            orphanRemoval = true,
    fetch = FetchType.LAZY)
    private List<Product> products = new ArrayList<>();
    @ManyToOne()
    @JoinColumn(name="restaurant_id")
    private RestaurantType restaurantType;

    @ManyToMany(mappedBy = "likedRestaurants", fetch = FetchType.LAZY)
    private Set<User> likedUsers = new HashSet<>();


    public Restaurant() {

    }

    public Restaurant(long id, String name, int speed, int service, int taste, String deliveryTime) {
        this.id = id;
        this.name = name;
        this.speed = speed;
        this.service = service;
        this.taste = taste;
        this.deliveryTime = deliveryTime;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public ImageFile getImage() {
        return image;
    }

    public void setImage(ImageFile image) {
        this.image = image;
    }

    public String getDeliveryTime() {
        return deliveryTime;
    }

    public void setDeliveryTime(String deliveryTime) {
        this.deliveryTime = deliveryTime;
    }

    public List<Product> getProducts() {
        return products;
    }

    public void setProducts(List<Product> products) {
        this.products = products;
    }

    public Set<User> getLikedUsers() {
        return likedUsers;
    }

    public void setLikedUsers(Set<User> likedUsers) {
        this.likedUsers = likedUsers;
    }
    public void setSpeed(double speed) {
        this.speed = speed;
    }

    public void setService(double service) {
        this.service = service;
    }

    public void setTaste(double taste) {
        this.taste = taste;
    }

    public double getAverageScore() {
        return averageScore;
    }

    public void setAverageScore(double averageScore) {
        this.averageScore = averageScore;
    }

    public double getSpeed() {
        return speed;
    }

    public double getService() {
        return service;
    }

    public double getTaste() {
        return taste;
    }

    public RestaurantType getRestaurantType() {
        return restaurantType;
    }

    public void setRestaurantType(RestaurantType restaurantType) {
        this.restaurantType = restaurantType;
    }
}
