package edu.rmit.highlandmimic.model.request;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ToppingRequestEntity {

    private String name;

    private String description;

    private String imageUrl;

    private Long pricePerService;

}
