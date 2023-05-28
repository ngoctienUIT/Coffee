package edu.rmit.highlandmimic.model;

import lombok.Builder;
import lombok.Data;
import org.springframework.data.mongodb.core.mapping.DBRef;

import java.util.List;

@Data
@Builder
public class OrderItem {

    @DBRef
    private Product product;
    private Integer quantity;
    private List<Topping> toppings;
    private String selectedSize;

}
