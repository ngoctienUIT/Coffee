package edu.rmit.highlandmimic.repository;

import edu.rmit.highlandmimic.model.Tag;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TagRepository extends MongoRepository<Tag, String> {

    List<Tag> getTagsByTagNameContains(String nameQuery);

}
