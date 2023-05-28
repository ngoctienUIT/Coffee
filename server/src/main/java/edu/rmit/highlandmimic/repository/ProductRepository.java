package edu.rmit.highlandmimic.repository;

import edu.rmit.highlandmimic.model.Product;
import java.util.List;
import java.util.Set;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductRepository extends MongoRepository<Product, String> {

  List<Product> getProductsByProductNameContainsIgnoreCase(String nameQuery);

  @Query("{ 'tags.tagId': { $in: ?0 } }")
  List<Product> findByTagIds(Set<String> tagIds);
}
