package com.example.restaurantbackend.responses;

public class HomeResponseItem {

    private String name;
    private long imageID;
    private long id;

    public  String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public long getImageID() {
        return imageID;
    }

    public void setImageID(long imageID) {
        this.imageID = imageID;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }
}
