package com.example.restaurantbackend.responses;

import java.util.List;

public class ProductSearchMainResponse {
    private int pageCount;
    private List<SearchResponse> searchResponse;

    public int getPageCount() {
        return pageCount;
    }

    public void setPageCount(int pageCount) {
        this.pageCount = pageCount;
    }

    public List<SearchResponse> getSearchResponse() {
        return searchResponse;
    }

    public void setSearchResponse(List<SearchResponse> searchResponse) {
        this.searchResponse = searchResponse;
    }
}
