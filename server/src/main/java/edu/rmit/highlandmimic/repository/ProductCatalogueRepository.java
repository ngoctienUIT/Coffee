package edu.rmit.highlandmimic.repository;

import edu.rmit.highlandmimic.model.ProductCatalogue;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductCatalogueRepository extends MongoRepository<ProductCatalogue, String> {

    List<ProductCatalogue> getProductCataloguesByProductCatalogueNameContainsIgnoreCase(String nameQuery);

}