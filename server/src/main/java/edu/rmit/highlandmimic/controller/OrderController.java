package edu.rmit.highlandmimic.controller;

import edu.rmit.highlandmimic.model.User;
import edu.rmit.highlandmimic.model.request.OrderRequestEntity;
import edu.rmit.highlandmimic.service.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static edu.rmit.highlandmimic.common.ControllerUtils.controllerWrapper;

@RestController
@RequestMapping("/order")
@RequiredArgsConstructor
public class OrderController {

    private final OrderService orderService;
    private final SecurityHandler securityHandler;

    @GetMapping
    public ResponseEntity<?> getOrdersOfUser(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                             @RequestParam String userIdentity,
                                             @RequestParam String status) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> orderService.getOrdersOfUser(userIdentity, status),
                SecurityHandler.ALLOW_STAKEHOLDERS
        );
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getOrderById(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                          @PathVariable String id) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> orderService.getOrderById(id),
                SecurityHandler.ALLOW_STAKEHOLDERS
        );
    }

    // WRITE Operations
    @PostMapping
    public ResponseEntity<?> createNewOrder(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                            @RequestBody OrderRequestEntity reqEntity) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> orderService.createNewOrder(reqEntity),
                List.of(User.UserRole.CUSTOMER)
        );
    }

    // MODIFY Operations

    @PostMapping("/{id}")
    public ResponseEntity<?> updatePendingOrder(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                                @PathVariable String id,
                                                @RequestBody OrderRequestEntity reqEntity) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> orderService.updatePendingOrder(id, reqEntity),
                List.of(User.UserRole.CUSTOMER)
        );
    }

    @PostMapping("/{id}/place-order")
    public ResponseEntity<?> placeOrder(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                        @PathVariable String id) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> orderService.placeOrder(id),
                List.of(User.UserRole.CUSTOMER)
        );
    }

    @PostMapping("/{id}/coupons")
    public ResponseEntity<?> attachCouponsOntoOrder(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                                    @PathVariable String id,
                                                    @RequestBody String couponId) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> orderService.attachCouponsOntoOrder(id, couponId),
                List.of(User.UserRole.CUSTOMER)
        );
    }

    // only ADMIN / STAFF role could perform this
    @PostMapping("/{id}/close")
    public ResponseEntity<?> closeSuccessfulOrder(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                                  @PathVariable String id) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> orderService.closeSuccessfulOrder(id),
                SecurityHandler.ALLOW_AUTHORITIES
        );
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> cancelOrder(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                         @PathVariable String id) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> orderService.cancelOrder(id),
                SecurityHandler.ALLOW_STAKEHOLDERS
        );
    }

    @DeleteMapping("/dev/all")
    public ResponseEntity<?> removeAllOrder() {
        return controllerWrapper(orderService::removeAllOrder);
    }

    @DeleteMapping("/truncate-cart")
    public ResponseEntity<?> truncateCart(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                          @RequestParam String userIdentity) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> orderService.truncateCart(userIdentity),
                List.of(User.UserRole.CUSTOMER)
        );
    }



}
