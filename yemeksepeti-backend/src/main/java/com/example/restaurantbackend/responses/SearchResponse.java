package com.example.restaurantbackend.responses;

import com.example.restaurantbackend.model.Product;

import java.util.List;

public class SearchResponse extends RestaurantResponse {

    private List<ProductResponse> productResponseList;

    public List<ProductResponse> getProductResponseList() {
        return productResponseList;
    }

    public void setProductResponseList(List<ProductResponse> productResponseList) {
        this.productResponseList = productResponseList;
    }
}
