package edu.rmit.highlandmimic.model;

import lombok.Builder;
import lombok.Data;
import lombok.NonNull;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.annotation.Version;
import org.springframework.data.mongodb.core.mapping.Document;

@Data
@Builder
@Document("posts")
public class Post {

    @Id
    private String postId;

    @NonNull
    private String title;
    private String content;

    private String imageUrl;
    private String collectionId;

    @CreatedDate
    private String uploadedDate;

    @LastModifiedDate
    private String lastUpdatedDate;

    @Version
    private String postVersion;
    private String shortenedContent;
}
