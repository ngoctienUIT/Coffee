package edu.rmit.highlandmimic.service;

import edu.rmit.highlandmimic.model.Coupon;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.stereotype.Component;

// Junit5 / TestNg, AssertJ

import static org.junit.jupiter.api.Assertions.*;
@Component
@SpringBootTest
class CouponServiceTest {

    @Autowired
    private CouponService couponService;

    @Test
    void getCouponById_shouldReturnValue() {
        // create inputs & create mocks
        String inputId = "641e09cfb14aa414f0f63262";

        // pass input into method and get "actual value"
        Coupon actualData = couponService.getCouponById(inputId);

        // create expected output & compare
        assertTrue(actualData.getId().equals(inputId)); // check 1
        assertTrue(actualData.getCouponName().equals("Nhiệt hè tưng bừng")); // check 2
    }

    @Test
    void getCouponById_shouldReturnNull_whenGivenWrongId() {
        // create inputs & create mocks
        String inputId = "wrongId";

        // pass input into method and get "actual value"
        Coupon actualData = couponService.getCouponById(inputId);

        // create expected output & compare
        assertTrue(actualData.getId().equals(inputId)); // check 1
        assertTrue(actualData.getCouponName().equals("Nhiệt hè tưng bừng")); // check 2
    }
}