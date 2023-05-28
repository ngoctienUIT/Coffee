package edu.rmit.highlandmimic.model.request;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class CouponRequestEntity {
    private String name;
    private String content;
    private String code;
    private String imageUrl;
    private String dueDate;

    private Double rate;
    private Long amount;
    private Long capAmount;
    private Long minimumAmountCriterion;
}
