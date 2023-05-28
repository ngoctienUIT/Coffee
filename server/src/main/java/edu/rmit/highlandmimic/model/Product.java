package edu.rmit.highlandmimic.model;

import lombok.Builder;
import lombok.Data;
import lombok.NonNull;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;
import java.util.Map;

@Data
@Builder
@Document("products")
public class Product {

    @Id
    private String productId;

    @NonNull
    private String productName;

    private Long price;

    @Builder.Default
    private String currency = "đ";
    private String imageUrl;
    private String description;
    private Map<String, Long> upsizeOptions;
    private List<Topping> toppingOptions;
    private List<Tag> tags;
}
