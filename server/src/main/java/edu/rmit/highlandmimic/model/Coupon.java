package edu.rmit.highlandmimic.model;

import lombok.Builder;
import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Data
@Builder
@Document("coupons")
public class Coupon {

    @Id
    private String id;
    private String couponName;
    private String couponCode;
    private String content;
    private String imageUrl;
    private String dueDate;
    private Double discountRate;
    private Long discountAmount;
    private Long discountRateCapAmount;
    private Long minimumOrderAmountCriterion;

}
