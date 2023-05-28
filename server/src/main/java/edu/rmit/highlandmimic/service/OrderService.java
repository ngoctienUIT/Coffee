package edu.rmit.highlandmimic.service;

import edu.rmit.highlandmimic.model.*;
import edu.rmit.highlandmimic.model.request.OrderRequestEntity;
import edu.rmit.highlandmimic.repository.OrderRepository;
import lombok.RequiredArgsConstructor;
import lombok.SneakyThrows;
import org.apache.logging.log4j.util.Strings;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.function.Predicate;
import java.util.function.Supplier;

import static edu.rmit.highlandmimic.common.CommonUtils.getOrDefault;
import static edu.rmit.highlandmimic.common.ModelMappingHandlers.*;

@Service
@RequiredArgsConstructor
public class OrderService {

    private final OrderRepository orderRepository;
    private final ProductService productService;
    private final UserService userService;
    private final CouponService couponService;
    private final StoreService storeService;
    private final ToppingService toppingService;


    public List<Order> getOrdersOfUser(String userIdentity, String status) {

        List<Order> queryingOrders = null;

        if (Strings.isBlank(userIdentity)) {
            queryingOrders = orderRepository.findAll();
        } else {
            queryingOrders = Optional.ofNullable(userService.searchUserByIdentity(userIdentity))
                    .map(User::getUserId)
                    .map(orderRepository::getOrdersByUserIdContains)
                    .orElseThrow(() -> new NullPointerException("There is no user associated given userIdentity"));
        }

        if (Strings.isBlank(status)) {
            return queryingOrders;
        }

        return queryingOrders.stream()
                .filter(e -> e.getOrderStatus().equals(Order.OrderStatus.valueOf(status.toUpperCase())))
                .toList();
    }

    public Order getOrderById(String id) {
        return orderRepository.findById(id).orElse(null);
    }

    private List<OrderItem> transformFrom(List<OrderRequestEntity.OrderItemRequestEntity> orderItemRequestEntity) {

        return orderItemRequestEntity.stream()
                .map(e -> OrderItem.builder()
                    .product(productService.getProductById(e.getProductId()))
                    .quantity(e.getQuantity())
                    .toppings(convertListOfIdsToToppings(toppingService.getAllToppings(), e.getToppingIds()))
                    .selectedSize(e.getSelectedSize())
                    .build())
                .toList();
    }

    private String getCurrentDateTimeString() {
        return LocalDateTime.now(
                    ZoneId.of("Asia/Ho_Chi_Minh")
                ).format(
                    DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss")
                );
    }

    public Order createNewOrder(OrderRequestEntity reqEntity) {
        Order preparedOrder = Order.builder()
                .userId(reqEntity.getUserId())
                .orderItems(transformFrom(reqEntity.getOrderItems()))
                .selectedPaymentMethod((Order.PaymentMethod) getOrDefault(reqEntity.getPaymentMethod(), Order.PaymentMethod.CASH))
                .selectedPickupOption((Order.PickupOption) getOrDefault(reqEntity.getPickupOptions(), Order.PickupOption.AT_STORE))
                .appliedCoupon(couponService.getCouponById(reqEntity.getCouponId()))
                .orderStatus(Order.OrderStatus.PENDING)
                .orderCustomerNote(reqEntity.getOrderNote())
                .createdDate(getCurrentDateTimeString())
                .lastUpdated(getCurrentDateTimeString())
                .build();

        if (reqEntity.getPickupOptions().equals(Order.PickupOption.DELIVERY)) {
            preparedOrder.setAddress1(reqEntity.getAddress1());
            preparedOrder.setAddress2(reqEntity.getAddress2());
            preparedOrder.setAddress3(reqEntity.getAddress3());
            preparedOrder.setAddress4(reqEntity.getAddress4());
        } else {
            preparedOrder.setSelectedPickupStore(
                    storeService.getStoreById(reqEntity.getStoreId())
            );
        }

        preparedOrder.setOrderAmount(calculateAmountOfOrder(preparedOrder));

        return orderRepository.save(preparedOrder);
    }

    private Long calculateAmountOfOrder(Order preparedOrder) {
        Long totalAmount = 0L;

        for (OrderItem orderItem : preparedOrder.getOrderItems()) {
            Product selectedProduct = orderItem.getProduct();

            Long itemAmount = (selectedProduct.getPrice() + selectedProduct.getUpsizeOptions().get(orderItem.getSelectedSize()));
            Long toppingsAmount = orderItem.getToppings().stream()
                    .map(Topping::getPricePerService)
                    .reduce(0L, Long::sum);

            totalAmount += (itemAmount + toppingsAmount) * orderItem.getQuantity();
        }

        Long discountingAmount = CouponService.getCouponDiscountAmount(totalAmount, preparedOrder.getAppliedCoupon());

        return totalAmount - discountingAmount;
    }

    public Order attachCouponsOntoOrder(String id, String couponId) {
        return Optional.ofNullable(this.getOrderById(id))
                .map(loadedEntity -> {

                    List<Coupon> availableCoupons = couponService.getAvailableCouponsForUser(loadedEntity.getUserId());
                    Coupon applyingCoupon = couponService.getCouponById(couponId);

                    if (!availableCoupons.contains(applyingCoupon)) {
                        throw new IllegalArgumentException("This coupon has been already used by the user. Please try another coupon");
                    }

                    loadedEntity.setAppliedCoupon(applyingCoupon);
                    loadedEntity.setOrderAmount(calculateAmountOfOrder(loadedEntity));
                    return orderRepository.save(loadedEntity);
                })
                .orElseThrow();
    }

    @SneakyThrows
    private Order changeStateOfOrder(String id,
                                    Order.OrderStatus destinationStatus,
                                    Predicate<Order> assignmentPrecondition,
                                    Supplier<? extends Exception> exceptionWhenCheckFailed) {
        Order loadedOrder = Optional.ofNullable(this.getOrderById(id)).orElseThrow();
        return Optional.of(loadedOrder).filter(assignmentPrecondition)
                .map(loadedEntity -> {
                    loadedEntity.setOrderStatus(destinationStatus);
                    loadedEntity.setLastUpdated(getCurrentDateTimeString());
                    return orderRepository.save(loadedEntity);
                })
                .orElseThrow(exceptionWhenCheckFailed);
    }

    public Order closeSuccessfulOrder(String id) {
        return this.changeStateOfOrder(
                id,
                Order.OrderStatus.COMPLETED,
                order -> order.getOrderStatus().equals(Order.OrderStatus.PLACED),
                () -> new IllegalStateException("Cannot close an order which is not in 'PLACED' state")
        );
    }

    public Order cancelOrder(String id) {
        return this.changeStateOfOrder(
                id,
                Order.OrderStatus.CANCELLED,
                order -> order.getOrderStatus().equals(Order.OrderStatus.PLACED),
                () -> new IllegalStateException("Cannot cancel an order which is not in 'PLACED' state")
        );
    }

    public Object placeOrder(String id) {
        return this.changeStateOfOrder(
            id,
            Order.OrderStatus.PLACED,
            order -> !order.getOrderStatus().equals(Order.OrderStatus.PLACED),
            () -> new IllegalStateException("Cannot place an order which is already in 'PLACED' state")
        );
    }

    public Order updatePendingOrder(String id, OrderRequestEntity reqEntity) {
        Order loadedOrder = Optional.ofNullable(this.getOrderById(id)).orElseThrow();

        Order preparedOrder = Optional.of(loadedOrder)
                .filter(order -> order.getOrderStatus().equals(Order.OrderStatus.PENDING))
                .map(loadedEntity -> {
                    loadedEntity.setOrderItems(transformFrom(reqEntity.getOrderItems()));
                    loadedEntity.setAppliedCoupon(couponService.getCouponById(reqEntity.getCouponId()));
                    loadedEntity.setSelectedPickupStore(storeService.getStoreById(reqEntity.getStoreId()));
                    loadedEntity.setSelectedPaymentMethod(reqEntity.getPaymentMethod());
                    loadedEntity.setSelectedPickupOption(reqEntity.getPickupOptions());
                    loadedEntity.setOrderAmount(calculateAmountOfOrder(loadedEntity));
                    loadedEntity.setOrderCustomerNote(reqEntity.getOrderNote());
                    loadedEntity.setLastUpdated(getCurrentDateTimeString());

                    if (reqEntity.getPickupOptions().equals(Order.PickupOption.DELIVERY)) {
                        loadedEntity.setAddress1(reqEntity.getAddress1());
                        loadedEntity.setAddress2(reqEntity.getAddress2());
                        loadedEntity.setAddress3(reqEntity.getAddress3());
                        loadedEntity.setAddress4(reqEntity.getAddress4());
                    } else {
                        loadedEntity.setSelectedPickupStore(
                                storeService.getStoreById(reqEntity.getStoreId())
                        );
                    }

                    return loadedEntity;
                }).orElseThrow();

        return orderRepository.save(preparedOrder);
    }

    public List<Order> getAllOrdersByStatus(String orderStatus) {
        return orderRepository.findAllByOrderStatusEquals(orderStatus);
    }

    public long removeAllOrder() {
        long quantity = orderRepository.count();
        orderRepository.deleteAll();
        return quantity;
    }

    public List<Order> truncateCart(String userIdentity) {
        List<Order> pendingOrders = this.getOrdersOfUser(userIdentity, "PENDING");

        pendingOrders.stream().map(Order::getOrderId).forEach(orderRepository::deleteById);

        return pendingOrders;
    }
}
