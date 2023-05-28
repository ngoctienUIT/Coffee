package edu.rmit.highlandmimic.repository;

import edu.rmit.highlandmimic.model.Post;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PostRepository extends MongoRepository<Post, String> {

    List<Post> getPostsByTitleContainsIgnoreCase(String nameQuery);

}
