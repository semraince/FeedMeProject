package com.example.restaurantbackend.service;

import com.example.restaurantbackend.dtos.OrderDto;
import com.example.restaurantbackend.model.Product;
import com.example.restaurantbackend.model.ProductType;
import com.example.restaurantbackend.model.Restaurant;
import com.example.restaurantbackend.model.User;
import com.example.restaurantbackend.repository.ProductRepository;
import com.example.restaurantbackend.repository.ProductTypeRepository;
import com.example.restaurantbackend.repository.RestaurantRepository;
import com.example.restaurantbackend.request.ProductRequest;
import com.example.restaurantbackend.responses.*;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.net.URLDecoder;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class ProductService {

    @Autowired
    ProductRepository productRepository;
    @Autowired
    RestaurantService restaurantService;
    @Autowired
    ProductTypeRepository productTypeRepository;
    @Autowired
    RestaurantRepository restaurantRepository;
    @Autowired
    UserService userService;
    public Product save(String restaurant){
        ProductRequest productRequest = generateFromJson(restaurant);
        Product product = new Product();
        product.setName(productRequest.getName());
        product.setProductType(productTypeRepository.getById(productRequest.getProductTypeId()));
        product.setPrice(productRequest.getPrice());
        product.setIngredients(productRequest.getIngredients());
        return product;
    }

    public Product save(Product product){
        return productRepository.save(product);
    }

    public ProductType createProductType(String name){
        ProductType productType = new ProductType(name);
        productTypeRepository.save(productType);
        return productType;

    }

    public Product getProduct(Long id){
        return productRepository.getById(id);
    }

    public Double getTotalPrice(List<OrderDto> orderDtos){
        Double totalPrice = 0.0;
        for(int i = 0; i<orderDtos.size(); i++){
            long id = orderDtos.get(i).orderId;
            Product product = productRepository.getById(id);
            totalPrice += product.getPrice()*orderDtos.get(i).count;

        }
        return totalPrice;
    }

    public ProductSearchMainResponse getProductsByName(String text, int page, Long userId){
        String tmpText = text;
        if(text != null){
            try {
                text = URLDecoder.decode(text, "UTF-8");
            } catch (UnsupportedEncodingException e) {
               text = tmpText;
            }
        }
        ProductSearchMainResponse productSearchMainResponse = new ProductSearchMainResponse();
        List<Product> productList = productRepository.findByNameContainingOrderById(text);
        Pageable paging = PageRequest.of(page, 10);
        Page<Restaurant> pageRestaurants = restaurantRepository.findByRestaurantsNameOrProductNameOrProductIngredients(text.toLowerCase(), text.toLowerCase(), text.toLowerCase(), text.toLowerCase(), paging);
        int totalNumberOfPage = pageRestaurants.getTotalPages();
        productSearchMainResponse.setPageCount(totalNumberOfPage);
        List<Restaurant> restaurants = pageRestaurants.getContent();
        List<SearchResponse> searchResponses = new ArrayList<>();
        if(restaurants != null && restaurants.size() > 0){
            List<Long> restaurantIds = restaurants.stream().map(o -> o.getId()).collect(Collectors.toList());
            List<Product> products = productRepository.findByNameContainingAndRestaurant(text.toLowerCase(), text.toLowerCase(), restaurantIds);
            Map<Long, List<Product>> productListGroups =
                    productList.stream().collect(Collectors.groupingBy(w -> w.getRestaurant().getId()));
           for(Restaurant restaurant: restaurants){
               SearchResponse searchResponse  = (SearchResponse) restaurantService.getRestaurantResponse(restaurant,userId, SearchResponse.class.getName());
               List<Product> productWithRestaurant = products.stream().filter(p -> restaurant.getId() == p.getRestaurant().getId()).collect(Collectors.toList());

               if(productWithRestaurant != null && productWithRestaurant.size() > 0){
                   int max = productWithRestaurant.size() > 3 ? 3 : productWithRestaurant.size();
                   List<Product> maxProductList = productWithRestaurant.subList(0, max);
                   List<ProductResponse> productResponseList = getProductResponseList(maxProductList);
                   searchResponse.setProductResponseList(productResponseList);
               }
                searchResponses.add(searchResponse);
           }

        }
        productSearchMainResponse.setSearchResponse(searchResponses);

        return productSearchMainResponse;

    }

    public ProductResponse getProductResponse(Product product){
        ProductResponse productResponse = new ProductResponse();
        productResponse.setProductImageID(product.getImage().getId());
        productResponse.setPrice(product.getPrice());
        productResponse.setProductId(product.getId());
        productResponse.setName(product.getName());
        productResponse.setIngredients(product.getIngredients());
        productResponse.setProductId(product.getId());
        return productResponse;
    }

    public List<ProductResponse> getProductResponseList(List<Product> productList){
        List<ProductResponse> productResponses = new ArrayList<>();
        for(Product product: productList){
            ProductResponse productResponse = getProductResponse(product);
            productResponses.add(productResponse);
        }
        return productResponses;
    }

    public ProductRequest generateFromJson(String request){
        ProductRequest productRequest = new ProductRequest();
        ObjectMapper objectMapper = new ObjectMapper();
        try{
            productRequest = objectMapper.readValue(request, ProductRequest.class);
        } catch (JsonMappingException e) {

            e.printStackTrace();
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return productRequest;
    }


}
