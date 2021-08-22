package com.example.restaurantbackend.responses;

import com.example.restaurantbackend.model.Address;
import com.example.restaurantbackend.model.User;
import com.fasterxml.jackson.annotation.JsonInclude;

import java.util.List;

public class UserResponse {
    private Long id;
    private String email;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Double totalBasketPrice;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Address activeAddress;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }


    public Double getTotalBasketPrice() {
        return totalBasketPrice;
    }

    public void setTotalBasketPrice(Double totalBasketPrice) {
        this.totalBasketPrice = totalBasketPrice;
    }

    public Address getActiveAddress() {
        return activeAddress;
    }

    public void setActiveAddress(Address activeAddress) {
        this.activeAddress = activeAddress;
    }
}
