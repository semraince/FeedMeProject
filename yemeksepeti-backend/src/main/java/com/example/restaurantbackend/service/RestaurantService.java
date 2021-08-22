package com.example.restaurantbackend.service;

import com.example.restaurantbackend.dtos.BannerDto;
import com.example.restaurantbackend.model.*;
import com.example.restaurantbackend.repository.BannerRepository;
import com.example.restaurantbackend.repository.ProductTypeRepository;
import com.example.restaurantbackend.repository.RestaurantRepository;
import com.example.restaurantbackend.repository.RestaurantTypeRepository;
import com.example.restaurantbackend.request.RestaurantRequest;
import com.example.restaurantbackend.responses.*;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Service
public class RestaurantService {

    @Autowired
    RestaurantRepository restaurantRepository;
    @Autowired
    FileStorageService fileStorageService;

    @Autowired
    ProductTypeService productTypeService;

    @Autowired
    UserService userService;

    @Autowired
    BannerRepository bannerRepository;
    @Autowired
    ProductTypeRepository productTypeRepository;
    @Autowired
    RestaurantTypeRepository restaurantTypeRepository;

    public Restaurant save(long id, String restaurant){
        RestaurantRequest restaurantRequest = generateFromJson(restaurant);
        Restaurant restaurantModel = new Restaurant();
        restaurantModel.setName(restaurantRequest.getName());
        restaurantModel.setService(restaurantRequest.getService());
        restaurantModel.setSpeed(restaurantRequest.getSpeed());
        restaurantModel.setTaste(restaurantRequest.getTaste());
        restaurantModel.setDeliveryTime(restaurantRequest.getDeliveryTime());
        restaurantModel.setRestaurantType(restaurantTypeRepository.getById(id));
        restaurantModel.setAverageScore(restaurantRequest.getAverageScore());
        return restaurantRepository.save(restaurantModel);

    }

    public Restaurant getRestaurantById(long id){
        return restaurantRepository.getById(id);
    }

    public RestaurantRequest generateFromJson(String request){
        RestaurantRequest restaurantRequest = new RestaurantRequest();
        ObjectMapper objectMapper = new ObjectMapper();
        try{
            restaurantRequest = objectMapper.readValue(request, RestaurantRequest.class);
        } catch (JsonMappingException e) {
            e.printStackTrace();
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return restaurantRequest;
    }

    public Restaurant save(Restaurant restaurantModel) {
        return restaurantRepository.save(restaurantModel);
    }

    public List<RestaurantResponse> getRestaurants(Long userId){
        List<Restaurant> restaurants =  restaurantRepository.findAll();
        List<RestaurantResponse> restaurantResponses = new ArrayList<>();
        for (Restaurant restaurant:  restaurants){
            RestaurantResponse response = getRestaurantResponse(restaurant, userId, Restaurant.class.getName());
            restaurantResponses.add(response);
        }
        return restaurantResponses;

    }


    public RestaurantListPage getRestaurant(int page, Long userId){
        Pageable paging = PageRequest.of(page, 10);
        Page<Restaurant> pageRestaurants = restaurantRepository.findAll(paging);
        RestaurantListPage restaurantListPage = new RestaurantListPage();
        int totalNumberOfPage = pageRestaurants.getTotalPages();
        List<Restaurant> restaurants = new ArrayList<>();
        restaurants = pageRestaurants.getContent();
        List<RestaurantResponse> restaurantResponses = new ArrayList<>();
        for (Restaurant restaurant:  restaurants) {
            restaurantResponses.add(getRestaurantResponse(restaurant, userId, RestaurantResponse.class.getName()));
        }
        restaurantListPage.setRestaurantResponseList(restaurantResponses);
        restaurantListPage.setPageCount(totalNumberOfPage);
        return restaurantListPage;


    }

    public RestaurantResponse getRestaurantResponse(Restaurant restaurant, Long userId, String className) {
        RestaurantResponse response = new RestaurantResponse();
        try {
            response = (RestaurantResponse) Class.forName(className).getConstructor().newInstance();

            response.setId(restaurant.getId());
            response.setName(restaurant.getName());
            response.setSpeed(restaurant.getSpeed());
            response.setService(restaurant.getService());
            response.setImageID(restaurant.getImage().getId());
            response.setTaste(restaurant.getTaste());
            response.setDeliveryTime(restaurant.getDeliveryTime());
            response.setCategoryName(restaurant.getRestaurantType().getName());
            response.setAverageScore(restaurant.getAverageScore());
            response.setCategoryName(restaurant.getRestaurantType().getName());
            response.setType("item");
            if (userId != null) {
                User user = userService.getUser(userId);
                if (user.getLikedRestaurants().contains(restaurant)) {
                    response.setLikedByUser(true);
                }
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return response;
    }

    public  HomeResponseList getMainResponse(Long userId, int page){
        HomeResponseList homeResponseList = new HomeResponseList();
        List<MainResponseItem> mainResponseItemList = new ArrayList<>();
        if(page == 0) {
            List<Banner> banners = bannerRepository.findAll();
            mainResponseItemList.add(genereteFromBanner(banners));
            List<RestaurantType> restaurantTypes = restaurantTypeRepository.findAll();
            mainResponseItemList.add(generateFromProductType(restaurantTypes));
        }
        RestaurantListPage restaurantResponses =  getRestaurant(page, userId);
        int totalNumberOfPages =restaurantResponses.getPageCount();
        List<RestaurantResponse> restaurantResponseList = restaurantResponses.getRestaurantResponseList();
        if(restaurantResponseList!= null && restaurantResponseList.size() > 0){
            mainResponseItemList.addAll(restaurantResponseList);
        }
        homeResponseList.setMainResponseItemList(mainResponseItemList);
        homeResponseList.setTotalPages(totalNumberOfPages);
        return homeResponseList;

    }

    public BannerResponseItem generateFromProductType(List<RestaurantType> productTypeList){
        BannerResponseItem bannerResponseItem = new BannerResponseItem();
        bannerResponseItem.setType("category");
        List<HomeResponseItem> homeResponseItemList = new ArrayList<>();
        for(RestaurantType restaurantType: productTypeList){
            HomeResponseItem homeResponseItem = new HomeResponseItem();
            homeResponseItem.setId(restaurantType.getId());
            homeResponseItem.setName(restaurantType.getName());
            if(restaurantType.getImage()!= null){
                homeResponseItem.setImageID(restaurantType.getImage().getId());
            }
            homeResponseItemList.add(homeResponseItem);
        }
        bannerResponseItem.setHomeResponseItemList(homeResponseItemList);
        return bannerResponseItem;
    }
    public BannerResponseItem genereteFromBanner(List<Banner> bannerList){
        BannerResponseItem bannerResponseItem = new BannerResponseItem();
        bannerResponseItem.setType("banner");
        List<HomeResponseItem> homeResponseItemList = new ArrayList<>();
        for(Banner banner: bannerList){
            HomeResponseItem homeResponseItem = new HomeResponseItem();
            homeResponseItem.setId(banner.getId());
            homeResponseItem.setName(banner.getName());
            homeResponseItem.setImageID(banner.getImage().getId());
            homeResponseItemList.add(homeResponseItem);
        }
        bannerResponseItem.setHomeResponseItemList(homeResponseItemList);
        return bannerResponseItem;
    }

    public RestaurantType createRestaurantType(String name, MultipartFile file){
        RestaurantType restaurantType = new RestaurantType(name);
        ImageFile fileModel= new ImageFile();
        try {
            fileModel = fileStorageService.store(file);
            restaurantType.setImage(fileModel);
            fileModel.setRestaurantType(restaurantType);
            restaurantTypeRepository.save(restaurantType);
        } catch (IOException e) {
            e.printStackTrace();
        }

        return restaurantType;

    }


    public HomeResponseList findRestaurantsByTypeId(long restaurantTypeId, int page, Long userId){
        HomeResponseList homeResponseList = new HomeResponseList();
        Pageable paging = PageRequest.of(page, 10);
        Page<Restaurant> pageRestaurants = restaurantRepository.findByRestaurantType_Id(restaurantTypeId, paging);
        int totalNumberOfPage = pageRestaurants.getTotalPages();
        homeResponseList.setTotalPages(totalNumberOfPage);
        List<Restaurant> restaurants = new ArrayList<>();
        restaurants = pageRestaurants.getContent();
        List<Restaurant> resultRestaurants = new ArrayList<>();
        for(Restaurant restaurant: restaurants){
            restaurants.stream().anyMatch(o -> o.getRestaurantType().getId() == restaurantTypeId);
            resultRestaurants.add(restaurant);
        }
        List<RestaurantResponse> resultRestaurantResponses = new ArrayList<>();
        for(Restaurant restaurant: resultRestaurants){
            resultRestaurantResponses.add(getRestaurantResponse(restaurant, userId,RestaurantResponse.class.getName()));
        }
        List<MainResponseItem> mainResponseItems = new ArrayList<>();
        mainResponseItems.addAll(resultRestaurantResponses);
        homeResponseList.setMainResponseItemList(mainResponseItems);
        return homeResponseList;
    }



}
