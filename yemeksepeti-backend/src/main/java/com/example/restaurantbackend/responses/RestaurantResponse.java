package com.example.restaurantbackend.responses;

import com.example.restaurantbackend.model.Product;
import com.fasterxml.jackson.annotation.JsonInclude;

import java.util.List;

public class RestaurantResponse extends MainResponseItem{
    public String name;
    public long imageID;
    public long id;
    public double speed;
    public String categoryName;
    public Double averageScore;
    public double service;
    public double taste;
    public String deliveryTime;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    public Boolean likedByUser;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    public List<ProductTypeResponse> productTypeList;


    public void setName(String name) {
        this.name = name;
    }

    public void setTaste(int taste) {
        this.taste = taste;
    }

    public String getDeliveryTime() {
        return deliveryTime;
    }

    public void setDeliveryTime(String deliveryTime) {
        this.deliveryTime = deliveryTime;
    }

    public List<ProductTypeResponse> getProductTypeList() {
        return productTypeList;
    }

    public void setProductList(List<ProductTypeResponse> productTypeList) {
        this.productTypeList = productTypeList;
    }

    public Boolean getLikedByUser() {
        return likedByUser;
    }

    public void setLikedByUser(Boolean likedByUser) {
        this.likedByUser = likedByUser;
    }

    public void setProductTypeList(List<ProductTypeResponse> productTypeList) {
        this.productTypeList = productTypeList;
    }

    public void setSpeed(double speed) {
        this.speed = speed;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public Double getAverageScore() {
        return averageScore;
    }

    public void setAverageScore(Double averageScore) {
        this.averageScore = averageScore;
    }

    public void setService(double service) {
        this.service = service;
    }

    public void setTaste(double taste) {
        this.taste = taste;
    }

    public String getName() {
        return name;
    }

    public long getImageID() {
        return imageID;
    }

    public void setImageID(long imageID) {
        this.imageID = imageID;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
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
}
