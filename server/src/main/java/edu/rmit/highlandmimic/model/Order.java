package edu.rmit.highlandmimic.model;

import lombok.Builder;
import lombok.Data;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.DocumentReference;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@Data
@Builder
@Document("orders")
public class Order {

    @Id
    private String orderId;

    private String userId;

    private String createdDate;

    private String lastUpdated;

    private List<OrderItem> orderItems;

    @Builder.Default
    private PaymentMethod selectedPaymentMethod = PaymentMethod.CASH;

    @Builder.Default
    private PickupOption selectedPickupOption = PickupOption.AT_STORE;

    @DBRef
    private Store selectedPickupStore;

    private String address1;
    private String address2;
    private String address3;
    private String address4;

    private Long orderAmount;

    @DBRef
    private Coupon appliedCoupon;

    private OrderStatus orderStatus;

    private String orderCustomerNote;

    public enum OrderStatus {
        PENDING,
        PLACED,
        COMPLETED,
        CANCELLED
    }

    public enum PaymentMethod {
        CASH,
        BANK_CARD,
        MOMO,
        BANK_TRANSER
    }

    public enum PickupOption {
        AT_STORE,
        DELIVERY
    }
}
