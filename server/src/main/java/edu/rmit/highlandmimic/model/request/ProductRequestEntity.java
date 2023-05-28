package edu.rmit.highlandmimic.model.request;

import edu.rmit.highlandmimic.model.Tag;
import lombok.Builder;
import lombok.Data;

import java.util.List;
import java.util.Map;

@Data
@Builder
public class ProductRequestEntity {
    private String name;

    private Long price;

    private String imageUrl;
    private String description;
    private Map<String, Long> upsizeOptions;
    private List<String> toppingIds;
    private List<String> tagIds;
}
