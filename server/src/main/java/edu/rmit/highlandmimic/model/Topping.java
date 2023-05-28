package edu.rmit.highlandmimic.model;

import lombok.Builder;
import lombok.Data;
import lombok.NonNull;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Data
@Builder
@Document("toppings")
public class Topping {

    @Id
    private String toppingId;

    @NonNull
    private String toppingName;

    private String description;

    private String imageUrl;

    private Long pricePerService;

}
