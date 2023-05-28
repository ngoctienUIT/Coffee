package edu.rmit.highlandmimic.repository;

import edu.rmit.highlandmimic.model.Topping;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ToppingRepository extends MongoRepository<Topping, String> {

    List<Topping> getToppingsByToppingNameContains(String nameQuery);

}
