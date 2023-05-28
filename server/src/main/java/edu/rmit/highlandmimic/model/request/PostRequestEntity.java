package edu.rmit.highlandmimic.model.request;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class PostRequestEntity {

    private String title;
    private String content;
    private String imageUrl;
    private String collectionId;

}
