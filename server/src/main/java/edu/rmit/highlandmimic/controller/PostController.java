package edu.rmit.highlandmimic.controller;

import edu.rmit.highlandmimic.model.Post;
import edu.rmit.highlandmimic.model.User;
import edu.rmit.highlandmimic.model.request.PostRequestEntity;
import edu.rmit.highlandmimic.service.PostService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static edu.rmit.highlandmimic.common.ControllerUtils.controllerWrapper;

@Slf4j
@RestController
@RequestMapping("/posts")
@RequiredArgsConstructor
public class PostController {

    private final PostService postService;
    private final SecurityHandler securityHandler;

    @GetMapping
    public ResponseEntity<List<Post>> getAllPosts() {
        return ResponseEntity.ok(postService.getAllPosts());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Post> getPostById(@PathVariable String id) {
        return ResponseEntity.ok(postService.getPostById(id));
    }

    @GetMapping("/search")
    public ResponseEntity<List<Post>> searchPostsByName(@RequestParam String q) {
        return ResponseEntity.ok(postService.searchPostsByName(q));
    }

    // WRITE operation

    @PostMapping
    public ResponseEntity<?> createNewPost(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                           @RequestBody PostRequestEntity reqEntity) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> postService.createNewPost(reqEntity),
                SecurityHandler.ALLOW_AUTHORITIES
        );
    }

    // MODIFY operation

    @PostMapping("/{id}")
    public ResponseEntity<?> updateExistingPost(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                                @PathVariable String id,
                                                @RequestBody PostRequestEntity reqEntity) {

        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> postService.updateExistingPost(id, reqEntity),
                SecurityHandler.ALLOW_AUTHORITIES
        );
    }

    @PostMapping("/{id}/{fieldName}")
    public ResponseEntity<?> updateFieldValueOfExistingPost(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                                            @PathVariable String id,
                                                            @PathVariable String fieldName,
                                                            @RequestBody Object newValue) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> postService.updateFieldValueOfExistingPost(id, fieldName, newValue),
                SecurityHandler.ALLOW_AUTHORITIES
        );
    }

    // DELETE operation

    @DeleteMapping("/dev/all")
    public ResponseEntity<?> removeAllPosts(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                postService::removeAllPosts,
                List.of(User.UserRole.ADMIN)
        );
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> removePostById(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                            @PathVariable String id) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> postService.removePostById(id),
                SecurityHandler.ALLOW_AUTHORITIES
        );
    }

}
