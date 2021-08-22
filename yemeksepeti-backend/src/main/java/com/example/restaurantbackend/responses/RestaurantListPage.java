package com.example.restaurantbackend.responses;

import java.util.List;

public class RestaurantListPage {
    private int pageCount;
    private List<RestaurantResponse> restaurantResponseList ;

    public int getPageCount() {
        return pageCount;
    }

    public void setPageCount(int pageCount) {
        this.pageCount = pageCount;
    }

    public List<RestaurantResponse> getRestaurantResponseList() {
        return restaurantResponseList;
    }

    public void setRestaurantResponseList(List<RestaurantResponse> restaurantResponseList) {
        this.restaurantResponseList = restaurantResponseList;
    }
}
