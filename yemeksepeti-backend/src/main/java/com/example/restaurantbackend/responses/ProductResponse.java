package com.example.restaurantbackend.responses;

import com.fasterxml.jackson.annotation.JsonInclude;

public class ProductResponse {
    private long productId;
    private String name;
    private double price;
    private long productImageID;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private String ingredients;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public long getProductImageID() {
        return productImageID;
    }

    public void setProductImageID(long productImageId) {
        this.productImageID = productImageId;
    }

    public long getProductId() {
        return productId;
    }

    public void setProductId(long productId) {
        this.productId = productId;
    }

    public String getIngredients() {
        return ingredients;
    }

    public void setIngredients(String ingredients) {
        this.ingredients = ingredients;
    }
}
