package com.example.restaurantbackend.model;

import javax.persistence.*;

@Entity
@Table(name = "restaurantType")
public class RestaurantType {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    private String name;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "img_id")
    private ImageFile image;

    public RestaurantType(){

    }
    public RestaurantType(String name){
        this.name = name;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public ImageFile getImage() {
        return image;
    }

    public void setImage(ImageFile image) {
        this.image = image;
    }
}
