package edu.rmit.highlandmimic.repository;

import edu.rmit.highlandmimic.model.Coupon;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CouponRepository extends MongoRepository<Coupon, String> {

    List<Coupon> getCouponsByCouponNameContainsIgnoreCase(String nameQuery);

}