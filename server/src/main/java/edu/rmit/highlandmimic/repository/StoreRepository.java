package edu.rmit.highlandmimic.repository;

import edu.rmit.highlandmimic.model.Store;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StoreRepository extends MongoRepository<Store, String> {

    List<Store> getStoreByAddress4(String address4);
    List<Store> findStoresByStoreNameContainingIgnoreCase(String nameQuery);

    List<Store> removeStoreByStoreName(String name);
}
