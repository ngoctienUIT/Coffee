package edu.rmit.highlandmimic.controller;

import edu.rmit.highlandmimic.model.Tag;
import edu.rmit.highlandmimic.model.User;
import edu.rmit.highlandmimic.model.request.TagRequestEntity;
import edu.rmit.highlandmimic.service.TagService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static edu.rmit.highlandmimic.common.ControllerUtils.controllerWrapper;

@RestController
@RequestMapping("/tag")
@RequiredArgsConstructor
public class TagController {

    private final TagService tagService;
    private final SecurityHandler securityHandler;

    // READ operations

    @GetMapping
    public ResponseEntity<List<Tag>> getAllTags() {
        return ResponseEntity.ok(tagService.getAllTags());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Tag> getTagById(@PathVariable String id) {
        return ResponseEntity.ok(tagService.getTagById(id));
    }

    @GetMapping("/search")
    public ResponseEntity<List<Tag>> searchTagsByName(@RequestParam String q) {
        return ResponseEntity.ok(tagService.searchTagsByName(q));
    }

    // WRITE operation

    @PostMapping
    public ResponseEntity<?> createNewTag(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                          @RequestBody TagRequestEntity reqEntity) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> tagService.createNewTag(reqEntity),
                SecurityHandler.ALLOW_AUTHORITIES
        );
    }

    // MODIFY operation

    @PostMapping("/{id}")
    public ResponseEntity<?> updateExistingTag(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                               @PathVariable String id,
                                               @RequestBody TagRequestEntity reqEntity) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> tagService.updateExistingTag(id, reqEntity),
                SecurityHandler.ALLOW_AUTHORITIES
        );
    }

    @PostMapping("/{id}/{fieldName}")
    public ResponseEntity<?> updateFieldValueOfExistingTag(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                                           @PathVariable String id,
                                                          @PathVariable String fieldName,
                                                          @RequestBody Object newValue) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> tagService.updateFieldValueOfExistingTag(id, fieldName, newValue),
                SecurityHandler.ALLOW_AUTHORITIES
        );
    }

    // DELETE operation

    @DeleteMapping("/dev/all")
    public ResponseEntity<?> removeAllTags(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                tagService::removeAllTags,
                List.of(User.UserRole.ADMIN)
        );
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> removeTagById(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                           @PathVariable String id) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> tagService.removeTagById(id),
                SecurityHandler.ALLOW_AUTHORITIES
        );
    }

}