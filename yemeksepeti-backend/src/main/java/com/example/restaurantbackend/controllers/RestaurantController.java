package com.example.restaurantbackend.controllers;

import com.example.restaurantbackend.dtos.AddressDto;
import com.example.restaurantbackend.dtos.OrderDto;
import com.example.restaurantbackend.dtos.UserDto;
import com.example.restaurantbackend.model.*;
import com.example.restaurantbackend.responses.*;
import com.example.restaurantbackend.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.stream.Collectors;

@RestController
public class RestaurantController {

    @Autowired
    RestaurantAppService restaurantAppService;
    @Autowired
    FileStorageService fileStorageService;
    @Autowired
    RestaurantService restaurantService;
    @Autowired
    ProductService productService;
    @Autowired
    UserService userService;
    @Autowired
    AddressService addressService;
    @Autowired
    OrderService orderService;

    @PostMapping(path = "{id}/restaurant",  consumes = { MediaType.APPLICATION_JSON_VALUE,MediaType.MULTIPART_FORM_DATA_VALUE })
    public ResponseEntity<String> createRestaurant(@PathVariable long id, @RequestPart("restaurant") String restaurant,
                                                   @RequestPart("file") MultipartFile file){
        restaurantAppService.saveRestaurant(id, restaurant, file);
          return new ResponseEntity<String>("Created", HttpStatus.OK);

    }

    @GetMapping(path = {"/getRestaurants", "/getRestaurants/{userId}"} )
    public List<RestaurantResponse> getRestaurants(@PathVariable(required = false) Long userId){
        return restaurantService.getRestaurants(userId);
    }

    @GetMapping(path = {"/getRestaurants/{page}/{userId}", "/getRestaurants/{page}"})
    public List<RestaurantResponse> getRestaurants(@PathVariable(required = false)  Long userId, @PathVariable int page){
        return restaurantService.getRestaurant(page, userId).getRestaurantResponseList();
    }

    @GetMapping(path = {"/getRestaurant/{userId}/{id}", "/getRestaurant/{id}"})
    public RestaurantResponse getRestaurant(@PathVariable(required = false) Long userId, @PathVariable long id){
        return restaurantAppService.getRestaurant(id, userId);
    }

    @PostMapping(path = "/createRestaurantType",  consumes = { MediaType.APPLICATION_JSON_VALUE,MediaType.MULTIPART_FORM_DATA_VALUE })
    public RestaurantType createRestaurantType(@RequestPart("type") String restaurantType,
                                               @RequestPart("file") MultipartFile file){
        return restaurantService.createRestaurantType(restaurantType, file);
    }

    @GetMapping(path="/getImage/{id}")
    public ResponseEntity<byte[]>  getFile(@PathVariable long id){
        ImageFile fileDB = fileStorageService.getFile(id);
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + fileDB.getName() + "\"")
                .body(fileDB.getData());

    }

    @PostMapping(path = "/{id}/product",  consumes = { MediaType.APPLICATION_JSON_VALUE,MediaType.MULTIPART_FORM_DATA_VALUE })
    public ResponseEntity<String> createProducts(@PathVariable long id, @RequestPart("product") String product,
                                 @RequestPart("file") MultipartFile file) {
        restaurantAppService.saveProduct(id, product ,file);
        return new ResponseEntity<String>("Created", HttpStatus.OK);

    }


    @PostMapping (path = "/createProductType/{name}")
    public ProductType createProducTypes(@PathVariable String name){
        return productService.createProductType(name);
    }


    @PostMapping(path = "/createUser")
    public UserResponse createUser(@RequestBody UserDto userDto){
        return userService.saveUser(userDto);
    }

    @PostMapping(path = "/createStatus/{statusName}")
    public Status createStatus(@PathVariable String statusName){
        Status status = orderService.createStatus(statusName);
        return status;
    }

    @PutMapping(path = "/updateOrder/{orderId}/{statusId}")
    public Order updateOrder(@PathVariable long orderId, @PathVariable long statusId){
        Order order = orderService.updateOrder(orderId, statusId);
        return order;
    }


    @GetMapping(path = "/getUser/{uid}")
    public UserResponse getUser(@PathVariable String uid){
        return userService.getUser(uid);
    }

    @GetMapping(path = "/userFavoriteRestaurants/{userId}")
    public List<RestaurantResponse> getFavoriteRestaurant(@PathVariable Long userId){
        return userService.getUserFavoriteRestaurants(userId);
    }

    @PostMapping(path = "/addFavorite/{userId}/{restaurantId}")
    public ResponseEntity<String> addFavoriteRestaurant(@PathVariable Long userId, @PathVariable long restaurantId){
        userService.addToFavorites(userId, restaurantId);
        return new ResponseEntity<>("result successful result",
                HttpStatus.OK);

    }

    @PostMapping(path = "/removeFavorite/{userId}/{restaurantId}")
    public ResponseEntity<String> removeFavoriteRestaurant(@PathVariable long userId, @PathVariable long restaurantId){
        userService.removeFromFavorites(userId, restaurantId);
        return new ResponseEntity<>("result successful result",
                HttpStatus.OK);
    }


    @PostMapping(path = "/createAddress")
    public List<Address> createAddress(@RequestBody AddressDto addressDto){
        return addressService.createAddress(addressDto);
    }

    @GetMapping(path = "/getAddressList/{userId}")
    public List<Address> getAddresses(@PathVariable long userId){
        User user = userService.getUser(userId);
        return user.getAddressList();
    }
    @GetMapping(path = "/getAddress/{userId}/{addressId}")
    public Address getSpecificAddress(@PathVariable long userId, @PathVariable long addressId){
        User user = userService.getUser(userId);
        return  user.getAddressList().stream().filter(address -> address.getId() == addressId).collect(Collectors.toList()).get(0);
    }
    @DeleteMapping(path = "/deleteAddress/{userId}/{addressId}")
    public List<Address> deleteAddress(@PathVariable long userId, long addressId){
        return addressService.deleteAddress(userId, addressId);
    }

    @PutMapping(path ="/changeActiveAddress/{addressId}/{userId}")
    public List<Address> updateActiveAddress(@PathVariable long userId, long addressId){
        return addressService.changeActiveAddress(userId, addressId);
    }

    @PostMapping(path = "/getTotalBasketPrice", produces = {MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<Double> createOrder(@RequestBody List<OrderDto> orderListDtos){
        Double totalPrice =  productService.getTotalPrice(orderListDtos);
        return new ResponseEntity<Double>(totalPrice, HttpStatus.OK);
    }


    @GetMapping(path = {"/search/{name}/{page}/{userId}", "/search/{name}/{page}"})
    public ProductSearchMainResponse getSearchResult(@PathVariable(required = false) Long userId, @PathVariable String name, @PathVariable int page){
        ProductSearchMainResponse searchResponses = productService.getProductsByName(name, page, userId);
        return searchResponses;
    }


    @GetMapping(path = {"/getCategory/{productTypeId}/{page}", "/restaurant/{productTypeId}/{page}/{userId}"})
    public HomeResponseList getRestaurantsByType(@PathVariable(required = false) Long userId, @PathVariable long productTypeId, @PathVariable int page){
        return restaurantService.findRestaurantsByTypeId(productTypeId, page, userId);
    }

    @GetMapping(path = {"/homeRequest/{page}", "/homeRequest/{page}/{userId}"})
    public HomeResponseList getHomePageInfo(@PathVariable(required = false) Long userId, @PathVariable  int page){
        return restaurantService.getMainResponse(userId, page);
    }

    @PostMapping(path = "/createBanner", consumes = { MediaType.APPLICATION_JSON_VALUE,MediaType.MULTIPART_FORM_DATA_VALUE })
    public ResponseEntity<String> createBanner(@RequestPart("banner") String banner, @RequestPart("file") MultipartFile file){
        restaurantAppService.saveBanner(banner, file);
        return new ResponseEntity<String>("Created", HttpStatus.OK);
    }

    @PostMapping(path = {"/addToBasket/{userId}/{productId}/{count}", "/addToBasket/{productId}/{count}"})
    public OrderResponse addToBasket(@PathVariable(required = false) Long userId, @PathVariable long productId, @PathVariable int count){
        return restaurantAppService.addToBasket(userId, productId, count);
    }

    @DeleteMapping(path = "/removeFromBasket/{userId}/{productId}")
    public OrderResponse removeFromBasket(@PathVariable Long userId, @PathVariable Long productId){
        return restaurantAppService.removeFromBasket(userId, productId);
    }
    @DeleteMapping(path = "/removeBasket/{userId}")
    public OrderResponse removeBasket(@PathVariable long userId){
         return restaurantAppService.cleanActiveOrder(userId);

    }
    @PutMapping(path = "/createOrder/{userId}")
    public OrderResponse createOrder(@PathVariable Long userId){
        return restaurantAppService.createOrder(userId);
    }

    @GetMapping(path = "/getBasket/{userId}")
    public OrderResponse getBasket(@PathVariable Long userId){
        return restaurantAppService.getBasket(userId);
    }
    @GetMapping(path = "/getPastOrders/{userId}")
    public List<Order> getPastOrders(@PathVariable Long userId){
        return restaurantAppService.getPastOrders(userId);
    }



}
