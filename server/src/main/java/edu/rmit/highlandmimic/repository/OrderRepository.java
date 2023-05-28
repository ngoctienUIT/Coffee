package edu.rmit.highlandmimic.repository;

import edu.rmit.highlandmimic.model.Order;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderRepository extends MongoRepository<Order, String> {

    List<Order> getOrdersByUserIdContains(String userId);

    List<Order> findAllByOrderStatusEquals(String orderStatus);
    
}
