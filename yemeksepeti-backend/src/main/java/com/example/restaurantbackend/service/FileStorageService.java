package com.example.restaurantbackend.service;

import com.example.restaurantbackend.model.ImageFile;
import com.example.restaurantbackend.repository.ImageFileRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Service
public class FileStorageService {
    @Autowired
    ImageFileRepository imageFileRepository;

    public ImageFile store(MultipartFile file) throws IOException {

        String fileName = StringUtils.cleanPath(file.getOriginalFilename());
        ImageFile imageFile = new ImageFile(fileName, file.getContentType(), file.getBytes());

        return imageFileRepository.save(imageFile);
    }

    public ImageFile getFile(long id){
        return imageFileRepository.getById(id);
    }

}
