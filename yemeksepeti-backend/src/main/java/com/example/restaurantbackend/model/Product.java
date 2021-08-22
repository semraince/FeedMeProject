package com.example.restaurantbackend.model;


import javax.persistence.*;

@Entity
@Table(name = "product")
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    private String name;
    private double price;
    private String ingredients;
    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "img_id")
    private ImageFile image;
    @ManyToOne()
    @JoinColumn(name="restaurant_id")
    private Restaurant restaurant;
    @ManyToOne()
    @JoinColumn(name="product_id")
    private ProductType productType;
    public Product() {
    }

    public Product(String name, double price, ImageFile image) {
        this.name = name;
        this.price = price;
        this.image = image;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public ImageFile getImage() {
        return image;
    }

    public void setImage(ImageFile image) {
        this.image = image;
    }

    public Restaurant getRestaurant() {
        return restaurant;
    }

    public void setRestaurant(Restaurant restaurant) {
        this.restaurant = restaurant;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getIngredients() {
        return ingredients;
    }

    public void setIngredients(String ingredients) {
        this.ingredients = ingredients;
    }

    public ProductType getProductType() {
        return productType;
    }

    public void setProductType(ProductType productType) {
        this.productType = productType;
    }
}
