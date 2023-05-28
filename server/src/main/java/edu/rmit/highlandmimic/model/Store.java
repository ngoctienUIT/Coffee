package edu.rmit.highlandmimic.model;

import lombok.Builder;
import lombok.Data;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.mongodb.core.mapping.Document;

@Data
@Builder(toBuilder = true)
@Document("stores")
public class Store {

    @Id
    private String storeId;

    private String storeName;
    private String address1;
    private String address2;
    private String address3;
    private String address4;

    @Builder.Default
    private String openingHour = "07:00";

    @Builder.Default
    private String closingHour = "23:00";
    private String latitude;
    private String longitude;

    private String imageUrl;

    private String hotlineNumber;

    private String googleMapUrl;

    @CreatedDate
    private String registrationDate;

    @LastModifiedDate
    private String lastUpdateDate;

    public static String toGoogleMapUrl(String lat, String lng) {
        return "https://www.google.com/maps/search/?api=1&query=" + lat + "&" + lng;
    }

}
