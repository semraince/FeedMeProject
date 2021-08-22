package com.example.restaurantbackend.service;

import com.example.restaurantbackend.model.ProductType;
import com.example.restaurantbackend.repository.ProductTypeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ProductTypeService {
    @Autowired
    ProductTypeRepository productTypeRepository;
    public ProductType getProductType(long id){
        return productTypeRepository.getById(id);
    }

    public List<ProductType> getProductTypeList(){
        return productTypeRepository.findAll();
    }

}
