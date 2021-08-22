package com.example.restaurantbackend.service;

import com.example.restaurantbackend.dtos.UserDto;
import com.example.restaurantbackend.model.*;
import com.example.restaurantbackend.repository.UserRepository;
import com.example.restaurantbackend.responses.RestaurantResponse;
import com.example.restaurantbackend.responses.UserResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class UserService {
    @Autowired
    UserRepository userRepository;

    @Autowired
    RestaurantService restaurantService;
    @Autowired
    AddressService addressService;
    @Autowired
    OrderService orderService;
    @Autowired
    ProductService productService;

    public UserResponse saveUser(UserDto userDto){
        User user = new User(userDto.getEmail(), userDto.getUserId());
        userRepository.save(user);
        UserResponse userResponse = new UserResponse();
        userResponse.setId(user.getId());
        userResponse.setEmail(user.getEmail());
        return userResponse;

    }

    private Double getTotalPrice(Long userId){
        User user = getUser(userId);
        List<Order> orderList = user.getOrderList();
        List<Order> activeOrders = orderList.stream().filter(o -> o.getStatus().getType().equals("ACTIVE")).collect(Collectors.toList());
        Order order = activeOrders == null || activeOrders.size() == 0 ? null : activeOrders.get(0);
        Double totalPrice = 0.0;
        if(order != null){
            for(OrderItem item: order.getOrderItemList()){
                Product productItem = productService.getProduct(item.getProductId());
                totalPrice = item.getCount() * productItem.getPrice();
            }
        }
        return totalPrice;
    }

    public UserResponse getUser(String userId){
        User user = userRepository.getUserByUserId(userId);
        Double totalPrice = getTotalPrice(user.getId());
        Address activeAddress = addressService.getActiveAddress(user.getId());
        UserResponse userResponse = getUserResponse(user);
        userResponse.setActiveAddress(activeAddress);
        userResponse.setTotalBasketPrice(totalPrice);
        return  userResponse;
    }
    public UserResponse getUserResponse(User user){
        UserResponse response = new UserResponse();
        response.setEmail(user.getEmail());
        response.setId(user.getId());
        return response;
    }
    public User getUser(long id){
        User user = userRepository.getById(id);

        return user;
    }



    public List<RestaurantResponse> getUserFavoriteRestaurants(long userId){
        User user = userRepository.getById(userId);
        Set<Restaurant> restaurants = user.getLikedRestaurants();
        List<RestaurantResponse> mainList = new ArrayList<RestaurantResponse>();
        for(Restaurant restaurant: restaurants){
            RestaurantResponse restaurantResponse = restaurantService.getRestaurantResponse(restaurant, userId, RestaurantResponse.class.getName());
            mainList.add(restaurantResponse);
        }
        return mainList;
    }

    public void addToFavorites(long userId, long restaurantId){
        User user = userRepository.getById(userId);
        Set<Restaurant> restaurants = user.getLikedRestaurants();
        Restaurant restaurant = restaurantService.getRestaurantById(restaurantId);
        user.getLikedRestaurants().add(restaurant);
        userRepository.save(user);
    }

    public void removeFromFavorites(long userId, long restaurantId){
        User user = userRepository.getById(userId);
        Restaurant restaurant = restaurantService.getRestaurantById(restaurantId);
        user.getLikedRestaurants().remove(restaurant);
        userRepository.save(user);
    }

    public User updateUser(User user){
       return userRepository.save(user);

    }



}
