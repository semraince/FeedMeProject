package com.example.restaurantbackend.responses;

import java.util.List;

public class BannerResponseItem extends MainResponseItem {
    private List<HomeResponseItem> homeResponseItemList;

    public List<HomeResponseItem> getHomeResponseItemList() {
        return homeResponseItemList;
    }

    public void setHomeResponseItemList(List<HomeResponseItem> homeResponseItemList) {
        this.homeResponseItemList = homeResponseItemList;
    }
}
