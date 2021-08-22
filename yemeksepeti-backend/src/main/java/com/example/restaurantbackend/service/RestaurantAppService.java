package com.example.restaurantbackend.service;

import com.example.restaurantbackend.dtos.OrderItemDto;
import com.example.restaurantbackend.model.*;
import com.example.restaurantbackend.repository.*;
import com.example.restaurantbackend.responses.OrderResponse;
import com.example.restaurantbackend.responses.ProductResponse;
import com.example.restaurantbackend.responses.ProductTypeResponse;
import com.example.restaurantbackend.responses.RestaurantResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class RestaurantAppService {
    @Autowired
    RestaurantService restaurantService;
    @Autowired
    FileStorageService fileStorageService;
    @Autowired
    ProductService productService;
    @Autowired
    ProductTypeService productTypeService;
    @Autowired
    UserService userService;
    @Autowired
    BannerRepository bannerRepository;
    @Autowired
    StatusRepository statusRepository;
    @Autowired
    OrderItemRepository orderItemRepository;
    @Autowired
    OrderRepository orderRepository;
    @Autowired
    ProductRepository productRepository;
    @Autowired
    AddressService addressService;

    public String saveRestaurant(long id, String restaurant, MultipartFile file){
        Restaurant restaurantModel = restaurantService.save(id, restaurant);
        ImageFile fileModel= new ImageFile();
        try {
            fileModel = fileStorageService.store(file);
            restaurantModel.setImage(fileModel);
            fileModel.setRestaurant(restaurantModel);
            restaurantService.save(restaurantModel);
            return "OK";
        } catch (IOException e) {
            return "Cannot store file";
        }
    }

    public String  saveBanner(String bannerName, MultipartFile file){
        Banner banner = new Banner(bannerName);
        ImageFile fileModel= new ImageFile();
        try {
            fileModel = fileStorageService.store(file);
            banner.setImage(fileModel);
            fileModel.setBanner(banner);
            bannerRepository.save(banner);
            return "OK";
        } catch (IOException e) {
            return "Cannot store file";
        }

    }

    public String saveProduct(long id, String request, MultipartFile file){
        Product product = productService.save(request);
        ImageFile fileModel = new ImageFile();

        try {
            fileModel = fileStorageService.store(file);
            product.setImage(fileModel);
            fileModel.setProduct(product);
            Restaurant restaurant = restaurantService.getRestaurantById(id);
            product.setRestaurant(restaurant);
            restaurant.getProducts().add(product);
            fileModel.setProduct(product);
            restaurantService.save(restaurant);
            return "OK";
        } catch (IOException e) {
            e.printStackTrace();
            return "NOT OK";
        }
    }

    public RestaurantResponse getRestaurant(Long id, Long userId){
        Restaurant restaurant = restaurantService.getRestaurantById(id);
        List<Product> products = restaurant.getProducts();
        List<ProductTypeResponse> productTypeRestaurantResponse = new ArrayList<>();
        if(products != null && products.size() > 0) {
            Map<Long, List<Product>> productListGroups =
                    products.stream().collect(Collectors.groupingBy(w -> w.getProductType().getId()));
            for (Long typeId : productListGroups.keySet()) {
                List<Product> productList = productListGroups.get(typeId);
                List<ProductResponse> productResponseList = new ArrayList<>();
                ProductType productType = productTypeService.getProductType(typeId);
                ProductTypeResponse productTypeResponse = new ProductTypeResponse();
                productTypeResponse.setProductCategoryId(productType.getId());
                productTypeResponse.setProductCategoryName(productType.getName());
                for (Product product : productList) {
                    ProductResponse productResponse = new ProductResponse();
                    productResponse.setName(product.getName());
                    productResponse.setIngredients(product.getIngredients());
                    productResponse.setPrice(product.getPrice());
                    productResponse.setProductImageID(product.getImage().getId());
                    productResponse.setProductId(product.getId());
                    productResponseList.add(productResponse);
                }
                productTypeResponse.setProductList(productResponseList);
                productTypeRestaurantResponse.add(productTypeResponse);

            }
        }
        RestaurantResponse restaurantResponse = restaurantService.getRestaurantResponse(restaurant, userId, RestaurantResponse.class.getName());
        restaurantResponse.setProductList(productTypeRestaurantResponse);
        return restaurantResponse;
    }

    public OrderResponse addToBasket(Long userId, Long productId, int count){
        OrderResponse orderResponse = new OrderResponse();
        if(userId == null){
            orderResponse.setMessage("Sepete ürün eklemeden önce giriş yapmalısınız.");
            orderResponse.setErrorCode(5000L);
            return orderResponse;
        }
        User user = userService.getUser(userId);
        List<Address> addressList = user.getAddressList();
        if(addressList == null || addressList.size() == 0){
            String message = ("Sepete ürün eklemeden önce adres eklemelisiniz.");
            orderResponse.setErrorCode(5001L);
            orderResponse.setMessage(message);
            return orderResponse;
        }
        Product product = productRepository.getById(productId);
        List<Order> orderList = user.getOrderList();
        if(orderList == null || orderList.size() == 0){
            orderList = new ArrayList<>();
        }
        List<Order> activeOrders = orderList.stream().filter(o -> o.getStatus().getType().equals("ACTIVE")).collect(Collectors.toList());
        Order order = activeOrders == null || activeOrders.size() == 0 ? null : activeOrders.get(0);
        if(order == null){
            order = new Order();
            order.setUser(user);
            orderList.add(order);
            order.setRestaurantId(product.getRestaurant().getId());
            order.setStatus(statusRepository.getStatusByType("ACTIVE"));
            user.getOrderList().add(order);
        }
        if(order != null){
            Long restaurantId = order.getRestaurantId();
            if (restaurantId == null || (restaurantId!= null && restaurantId.equals(product.getRestaurant().getId()))){
                List<OrderItemDto> orderItemDtoList = new ArrayList<>();
                List<OrderItem> activeOrderItemList = order.getOrderItemList().stream().filter(o -> productId.equals(o.getProductId())).collect(Collectors.toList());
                OrderItem orderItem = new OrderItem();
                if(activeOrderItemList != null && activeOrderItemList.size() > 0){
                    orderItem = activeOrderItemList.get(0);
                    orderItem.setCount(count + orderItem.getCount());
                }
                else {
                    orderItem.setCount(count);
                    orderItem.setProductId(productId);
                    orderItem.setOrder(order);
                    order.getOrderItemList().add(orderItem);
                }
                Comparator<OrderItem> compareById = Comparator.comparing((OrderItem o) -> new Long(o.getId()));
                Collections.sort(order.getOrderItemList(), compareById);
                orderResponse = getOrderItemDtolist(order.getOrderItemList());
                Restaurant restaurant = restaurantService.getRestaurantById(product.getRestaurant().getId());
                RestaurantResponse restaurantResponse = restaurantService.getRestaurantResponse(restaurant, userId, RestaurantResponse.class.getName());
                orderResponse.setRestaurantResponse(restaurantResponse);
                orderItemRepository.save(orderItem);
                orderRepository.save(order);
            }
            else if(restaurantId.equals(product.getRestaurant().getId()) == false){
                    String message = "Sepetinizde farklı restoranlardan ürün olamaz. Sepetinize bu restoranın ürününü eklemek için sepetinizi boşaltmak ister misiniz ? ";
                    orderResponse.setErrorCode(5002L);
                    orderResponse.setMessage(message);
            }

        }
        return orderResponse;
    }


    private OrderResponse getOrderItemDtolist(List<OrderItem> orderItemList){
        List<OrderItemDto> orderItemDtoList = new ArrayList<>();
        OrderResponse orderResponse = new OrderResponse();
        Double totalPrice = 0.0;
        for(OrderItem activeOrderItem: orderItemList){
            OrderItemDto itemDto = new OrderItemDto();
            Product productItem = productRepository.getById(activeOrderItem.getProductId());
            Double price = activeOrderItem.getCount() * productItem.getPrice();
            itemDto.setIngredients(productItem.getIngredients());
            itemDto.setCount(activeOrderItem.getCount());
            itemDto.setProductId(productItem.getId());
            itemDto.setTotalPrice(price);
            itemDto.setName(productItem.getName());
            itemDto.setImageId(productItem.getImage().getId());
            totalPrice += price;
            orderItemDtoList.add(itemDto);
        }
        orderResponse.setTotalPrice(totalPrice);
        orderResponse.setOrderItemDtoList(orderItemDtoList);
        return orderResponse;
    }

    public OrderResponse cleanActiveOrder(long userId){
        User user = userService.getUser(userId);
        Order activeOrder = user.getOrderList().stream().filter(o -> o.getStatus().getType().equals("ACTIVE")).collect(Collectors.toList()).get(0);
        orderItemRepository.deleteAll();
        orderRepository.deleteOrderItemById(activeOrder.getId());
        OrderResponse orderResponse = new OrderResponse();
        orderResponse.setMessage("Sepet boşaltıldı");
        orderResponse.setErrorCode(200L);
        return orderResponse;
    }

    public OrderResponse getBasket(Long userId){
        User user = userService.getUser(userId);
        OrderResponse orderResponse = new OrderResponse();
        List<Order> orderList = user.getOrderList();
        if(orderList != null &&orderList.size() > 0) {
            List<Order> activeOrderList = orderList.stream().filter(o -> o.getStatus().getType().equals("ACTIVE")).collect(Collectors.toList());
            if(activeOrderList != null && activeOrderList.size() > 0){
                List<OrderItem> orderItemList = activeOrderList.get(0).getOrderItemList();
                Comparator<OrderItem> compareById = Comparator.comparing((OrderItem o) -> new Long(o.getId()));
                Collections.sort(orderItemList, compareById);
                orderResponse = getOrderItemDtolist(orderItemList);
                Product product = productService.getProduct(orderItemList.get(0).getProductId());
                Restaurant restaurant = product.getRestaurant();
                RestaurantResponse restaurantResponse = restaurantService.getRestaurantResponse(restaurant, userId, RestaurantResponse.class.getName());
                orderResponse.setRestaurantResponse(restaurantResponse);
            }
        }
        return orderResponse;
    }

    public OrderResponse removeFromBasket(Long userId, Long productId){
        OrderResponse orderResponse = new OrderResponse();
        User user = userService.getUser(userId);
        Product product = productRepository.getById(productId);
        Order activeOrder = user.getOrderList().stream().filter(o -> o.getStatus().getType().equals("ACTIVE")).collect(Collectors.toList()).get(0);
        OrderItem activeOrderItem = activeOrder.getOrderItemList().stream().filter(o -> productId.equals(o.getProductId())).collect(Collectors.toList()).get(0);
        int count = activeOrderItem.getCount() -1;
        if(count == 0){
            if(activeOrder.getOrderItemList().size() == 1){
                activeOrder.getOrderItemList().remove(activeOrderItem);
                orderRepository.save(activeOrder);
                orderRepository.deleteOrderItemById(activeOrder.getId());
            }
            else{
                activeOrder.getOrderItemList().remove(activeOrderItem);
                activeOrder = orderRepository.save(activeOrder);
            }

        }
        else{
            activeOrderItem.setCount(count);
            activeOrderItem.setPrice(count*product.getPrice());
            orderItemRepository.save(activeOrderItem);
        }
        if(activeOrder != null && activeOrder.getOrderItemList().size() > 0){
            Comparator<OrderItem> compareById = Comparator.comparing((OrderItem o) -> new Long(o.getId()));
            Collections.sort(activeOrder.getOrderItemList(), compareById);
            orderResponse = getOrderItemDtolist(activeOrder.getOrderItemList());

            Restaurant restaurant = restaurantService.getRestaurantById(product.getRestaurant().getId());
            RestaurantResponse restaurantResponse = restaurantService.getRestaurantResponse(restaurant, userId, RestaurantResponse.class.getName());
            orderResponse.setRestaurantResponse(restaurantResponse);
        }
        return orderResponse;
    }

    public OrderResponse createOrder(Long userId){
        OrderResponse orderResponse = new OrderResponse();
        if(userId == null){
            orderResponse.setErrorCode(5000L);
            orderResponse.setMessage("Siparişinizi tamamlamadan önce giriş yapmalısınız.");
            return orderResponse;
        }
        User user = userService.getUser(userId);
        Address activeAddress = addressService.getActiveAddress(userId);
        if(activeAddress == null){
            orderResponse.setErrorCode(5001L);
            orderResponse.setMessage("Siparişi tamamlamadan önce adres eklemelisiniz.");
            return orderResponse;
        }
        Order activeOrder = user.getOrderList().stream().filter(o -> o.getStatus().getType().equals("ACTIVE")).collect(Collectors.toList()).get(0);
        activeOrder.setOrderedDate(new Date());
        activeOrder.setStatus(statusRepository.getStatusByType("COMPLETED"));
        activeOrder.setAddress(activeAddress);
        orderResponse = getOrderItemDtolist(activeOrder.getOrderItemList());
        activeOrder.setTotalPrice(orderResponse.getTotalPrice());
        orderRepository.save(activeOrder);
        Restaurant restaurant = restaurantService.getRestaurantById(activeOrder.getRestaurantId());
        RestaurantResponse restaurantResponse = restaurantService.getRestaurantResponse(restaurant, userId, RestaurantResponse.class.getName());
        orderResponse.setRestaurantResponse(restaurantResponse);
        return orderResponse;
    }

    public List<Order> getPastOrders(Long userId){
        User user = userService.getUser(userId);
        List<Order> orderList = user.getOrderList().stream().filter(order -> order.getStatus().equals(statusRepository.getStatusByType("COMPLETED"))).collect(Collectors.toList());
        return orderList;

    }

}
