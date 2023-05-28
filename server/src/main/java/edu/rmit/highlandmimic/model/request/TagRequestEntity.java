package edu.rmit.highlandmimic.model.request;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class TagRequestEntity {
    private String name;
    private String description;
    private String color;
}
