package com.example.restaurantbackend.responses;

import com.example.restaurantbackend.model.ProductType;

import java.util.List;

public class ProductTypeResponse {
    private long productCategoryId;
    private String productCategoryName;
    private List<ProductResponse> productList;


    public List<ProductResponse> getProductList() {
        return productList;
    }

    public void setProductList(List<ProductResponse> productList) {
        this.productList = productList;
    }

    public long getProductCategoryId() {
        return productCategoryId;
    }

    public void setProductCategoryId(long productCategoryId) {
        this.productCategoryId = productCategoryId;
    }

    public String getProductCategoryName() {
        return productCategoryName;
    }

    public void setProductCategoryName(String productCategoryName) {
        this.productCategoryName = productCategoryName;
    }
}
