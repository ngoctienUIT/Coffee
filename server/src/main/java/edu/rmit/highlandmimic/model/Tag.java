package edu.rmit.highlandmimic.model;

import lombok.Builder;
import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Data
@Builder(toBuilder = true)
@Document("tags")
public class Tag {

    @Id
    private String tagId;

    private String tagName;
    private String tagDescription;

    @Builder.ObtainVia(method = "generateRandomColorCode")
    private String tagColorCode;

    public static String generateRandomColorCode() {
        return String.format("#%06X", (int) (Math.random() * 0xFFFFFF));
    }
}
