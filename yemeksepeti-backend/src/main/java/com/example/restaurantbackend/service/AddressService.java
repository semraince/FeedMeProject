package com.example.restaurantbackend.service;

import com.example.restaurantbackend.dtos.AddressDto;
import com.example.restaurantbackend.model.Address;
import com.example.restaurantbackend.model.User;
import com.example.restaurantbackend.repository.AddressRepository;
import com.example.restaurantbackend.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class AddressService {
    @Autowired
    AddressRepository addressRepository;
    @Autowired
    UserService userService;
    @Autowired
    UserRepository userRepository;

    @Transactional
    public List<Address> createAddress(AddressDto addressDto){
        User user = userService.getUser(addressDto.getUserId());
        Address address = new Address(addressDto.getName(),addressDto.getCity(), addressDto.getDistrict(), addressDto.getStreet(),addressDto.getApartmentNo()
        ,addressDto.getFloorNo(), addressDto.getPhoneNumber(), addressDto.getUserName(), addressDto.getUserSurname());
        List<Address> addressList = addressRepository.getAddressesByUserOrderById(addressDto.getUserId());
        if(addressList != null && addressList.size() > 0){
           Address activeAddress =  addressList.stream().filter(a -> Boolean.TRUE.equals(a.getIsActive())).collect(Collectors.toList()).get(0);
           activeAddress.setIsActive(false);
           addressRepository.save(activeAddress);
        }
        address.setIsActive(true);
        user.getAddressList().add(address);
        address.setUser(user);
        addressRepository.save(address);
        addressList.add(address);
        return addressList;
    }

    public Address getActiveAddress(Long userId){
        Address activeAddress = addressRepository.getActiveAddressByUserId(userId);
        return activeAddress;
    }

    @Transactional
    public List<Address> changeActiveAddress(Long userId, Long addressId){
        List<Address> addressList = addressRepository.getAddressesByUserOrderById(userId);
        Address activatedAddress = addressList.stream().filter(a->addressId.equals(a.getId())).collect(Collectors.toList()).get(0);
        Address activeAddress = addressList.stream().filter(a->Boolean.TRUE.equals(a.getIsActive())).collect(Collectors.toList()).get(0);
        activatedAddress.setIsActive(false);
        activatedAddress.setIsActive(true);
        addressRepository.save(activatedAddress);
        addressRepository.save(activeAddress);
        return addressList;
    }

    public List<Address> deleteAddress(Long userId, Long addressId){
        List<Address> addressList = addressRepository.getAddressesByUserOrderById(userId);
        Address removedAddress = addressList.stream().filter(a -> addressId.equals(a.getId())).collect(Collectors.toList()).get(0);
        if(Boolean.TRUE.equals(removedAddress.getIsActive())){
            if(addressList.size() >1 ){
                if(addressList.get(0).getId() == removedAddress.getId()){
                    addressList.get(1).setIsActive(true);
                }
                else{
                    addressList.get(0).setIsActive(true);
                }
            }

        }
        addressList.remove(removedAddress);
        return addressList;
    }
}
