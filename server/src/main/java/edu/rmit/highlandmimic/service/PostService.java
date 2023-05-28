package edu.rmit.highlandmimic.service;

import edu.rmit.highlandmimic.model.Post;
import edu.rmit.highlandmimic.model.request.PostRequestEntity;
import edu.rmit.highlandmimic.repository.PostRepository;
import lombok.RequiredArgsConstructor;
import lombok.SneakyThrows;
import org.springframework.stereotype.Service;

import java.lang.reflect.Field;
import java.util.List;

import static java.util.Optional.ofNullable;

@Service
@RequiredArgsConstructor
public class PostService {

    private final PostRepository postRepository;

    // READ operations

    public List<Post> getAllPosts() {
        return postRepository.findAll();
    }

    public Post getPostById(String id) {
        return postRepository.findById(id).orElse(null);
    }

    public List<Post> searchPostsByName(String nameQuery) {
        return postRepository.getPostsByTitleContainsIgnoreCase(nameQuery);
    }

    // WRITE operations

    public Post createNewPost(PostRequestEntity reqEntity) {
        Post preparedPost = Post.builder()
                .title(reqEntity.getTitle())
                .content(reqEntity.getContent())
                .imageUrl(reqEntity.getImageUrl())
                .collectionId(reqEntity.getCollectionId())
                .build();

        return postRepository.save(preparedPost);
    }

    // MODIFY operations

    public Post updateExistingPost(String id, PostRequestEntity reqEntity) {

        Post preparedPost = postRepository.findById(id)
                .map(loadedEntity -> {
                    loadedEntity.setTitle(reqEntity.getTitle());
                    loadedEntity.setContent(reqEntity.getContent());
                    loadedEntity.setImageUrl(reqEntity.getImageUrl());
                    loadedEntity.setCollectionId(reqEntity.getCollectionId());

                    return loadedEntity;
                }).orElseThrow();

        return postRepository.save(preparedPost);
    }

    @SneakyThrows
    public Post updateFieldValueOfExistingPost(String id, String fieldName, Object newValue) {
        Post preparedPost =  ofNullable(this.getPostById(id)).orElseThrow();

        Field preparedField = preparedPost.getClass().getDeclaredField(fieldName);
        preparedField.setAccessible(true);
        preparedField.set(preparedPost, newValue);

        return postRepository.save(preparedPost);
    }

    // DELETE operations

    public Post removePostById(String id) {
        return postRepository.findById(id)
                .map(loadedEntity -> {
                    postRepository.delete(loadedEntity);
                    return loadedEntity;
                }).orElseThrow();
    }

    public long removeAllPosts() {
        long quantity = postRepository.count();
        postRepository.deleteAll();
        return quantity;
    }

}