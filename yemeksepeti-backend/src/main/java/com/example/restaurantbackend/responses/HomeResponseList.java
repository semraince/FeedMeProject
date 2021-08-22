package com.example.restaurantbackend.responses;

import java.util.List;

public class HomeResponseList {
    private int totalPages;
    private List<MainResponseItem> mainResponseItemList;

    public int getTotalPages() {
        return totalPages;
    }

    public void setTotalPages(int totalPages) {
        this.totalPages = totalPages;
    }

    public List<MainResponseItem> getMainResponseItemList() {
        return mainResponseItemList;
    }

    public void setMainResponseItemList(List<MainResponseItem> mainResponseItemList) {
        this.mainResponseItemList = mainResponseItemList;
    }
}
