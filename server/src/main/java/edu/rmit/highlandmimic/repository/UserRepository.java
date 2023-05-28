package edu.rmit.highlandmimic.repository;

import edu.rmit.highlandmimic.model.User;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserRepository extends MongoRepository<User, String> {
    User findByUsernameIgnoreCase(String username);
    User findByEmailIgnoreCase(String email);
    User findByPhoneNumber(String phoneNumber);

    List<User> findAllByDisplayNameContainingIgnoreCase(String nameQuery);

    Boolean existsByUserId(String userId);
}
