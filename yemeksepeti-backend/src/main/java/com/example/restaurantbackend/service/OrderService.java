package com.example.restaurantbackend.service;

import com.example.restaurantbackend.model.Order;
import com.example.restaurantbackend.model.Status;
import com.example.restaurantbackend.repository.OrderRepository;
import com.example.restaurantbackend.repository.StatusRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OrderService {
    @Autowired
    StatusRepository statusRepository;

    @Autowired
    OrderRepository orderRepository;

    public Status createStatus(String name){
        Status status = new Status();
        status.setType(name);
        statusRepository.save(status);
        return  status;
    }

    public Order updateOrder(long orderId, long statusId){
        Order order = orderRepository.getById(orderId);
        Status status = statusRepository.getById(statusId);
        order.setStatus(status);
        orderRepository.save(order);
        return order;
    }
}
