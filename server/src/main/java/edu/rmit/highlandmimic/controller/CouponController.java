package edu.rmit.highlandmimic.controller;

import edu.rmit.highlandmimic.model.Coupon;
import edu.rmit.highlandmimic.model.User;
import edu.rmit.highlandmimic.model.request.CouponRequestEntity;
import edu.rmit.highlandmimic.service.CouponService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/coupon")
@RequiredArgsConstructor
public class CouponController {

    private final CouponService couponService;
    private final SecurityHandler securityHandler;

    // READ operations

    @GetMapping
    public ResponseEntity<List<Coupon>> getAllCoupons() {
        return ResponseEntity.ok(couponService.getAllCoupons());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Coupon> getCouponById(@PathVariable String id) {
        return ResponseEntity.ok(couponService.getCouponById(id));
    }

    @GetMapping("/available/{userId}")
    public ResponseEntity<List<Coupon>> getAvailableCouponsForUser(@PathVariable String userId) {
        return ResponseEntity.ok(couponService.getAvailableCouponsForUser(userId));
    }

    @GetMapping("/search")
    public ResponseEntity<List<Coupon>> searchCouponsByName(@RequestParam String q) {
        return ResponseEntity.ok(couponService.searchCouponsByName(q));
    }

    // WRITE operation

    @PostMapping
    public ResponseEntity<?> createNewCoupon(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                             @RequestBody CouponRequestEntity reqEntity) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> couponService.createNewCoupon(reqEntity),
                SecurityHandler.ALLOW_AUTHORITIES
        );
    }

    // MODIFY operation

    @PostMapping("/{id}")
    public ResponseEntity<?> updateExistingCoupon(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                                  @PathVariable String id, @RequestBody CouponRequestEntity reqEntity) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> couponService.updateExistingCoupon(id, reqEntity),
                SecurityHandler.ALLOW_AUTHORITIES
        );
    }

    @PostMapping("/{id}/{fieldName}")
    public ResponseEntity<?> updateFieldValueOfExistingCoupon(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                                              @PathVariable String id,
                                                              @PathVariable String fieldName,
                                                              @RequestBody Object newValue) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> couponService.updateFieldValueOfExistingCoupon(id, fieldName, newValue),
                SecurityHandler.ALLOW_AUTHORITIES
        );
    }

    // DELETE operation

    @DeleteMapping("/dev/all")
    public ResponseEntity<?> removeAllCoupons(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                couponService::removeAllCoupons,
                List.of(User.UserRole.ADMIN)
        );
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> removeCouponById(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                              @PathVariable String id) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> couponService.removeCouponById(id),
                List.of(User.UserRole.ADMIN)
        );
    }

}