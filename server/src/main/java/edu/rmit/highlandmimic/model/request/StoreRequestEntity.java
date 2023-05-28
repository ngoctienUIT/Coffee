package edu.rmit.highlandmimic.model.request;

import lombok.Builder;
import lombok.Data;
import lombok.NonNull;

@Data
@Builder
public class StoreRequestEntity {

    @NonNull
    private String name;

    private String address1;
    private String address2;
    private String address3;
    private String address4;

    private String latitude;
    private String longitude;

    private String imageUrl;
    private String hotlineNumber;
}
