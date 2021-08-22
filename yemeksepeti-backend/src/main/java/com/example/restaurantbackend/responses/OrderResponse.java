package com.example.restaurantbackend.responses;

import com.example.restaurantbackend.dtos.OrderItemDto;
import com.fasterxml.jackson.annotation.JsonInclude;

import java.util.List;

public class OrderResponse {

    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Long errorCode;

    @JsonInclude(JsonInclude.Include.NON_NULL)
    private String message;

    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Double totalPrice;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private RestaurantResponse restaurantResponse;


    private List<OrderItemDto> orderItemDtoList;

    public Long getErrorCode() {
        return errorCode;
    }

    public void setErrorCode(Long errorCode) {
        this.errorCode = errorCode;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public RestaurantResponse getRestaurantResponse() {
        return restaurantResponse;
    }

    public void setRestaurantResponse(RestaurantResponse restaurantResponse) {
        this.restaurantResponse = restaurantResponse;
    }

    public List<OrderItemDto> getOrderItemDtoList() {
        return orderItemDtoList;
    }

    public void setOrderItemDtoList(List<OrderItemDto> orderItemDtoList) {
        this.orderItemDtoList = orderItemDtoList;
    }
}
