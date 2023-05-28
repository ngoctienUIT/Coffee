package edu.rmit.highlandmimic.model.request;

import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class ProductCatalogueRequestEntity {
    private String name;
    private String description;
    private String imageUrl;
//    private List<String> subCatalogueIds;
    private List<String> productIds;
}
