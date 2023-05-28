package edu.rmit.highlandmimic.controller;

import edu.rmit.highlandmimic.model.Store;
import edu.rmit.highlandmimic.model.User;
import edu.rmit.highlandmimic.model.request.StoreRequestEntity;
import edu.rmit.highlandmimic.service.StoreService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static edu.rmit.highlandmimic.common.ControllerUtils.controllerWrapper;


@RestController
@RequestMapping("/stores")
@RequiredArgsConstructor
public class StoreController {

    private final StoreService storeService;
    private final SecurityHandler securityHandler;


    // READ operations

    @GetMapping
    public ResponseEntity<List<Store>> getAllStores() {
        return ResponseEntity.ok(storeService.getAllStores());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Store> getStoreById(@PathVariable String id) {
        return ResponseEntity.ok(storeService.getStoreById(id));
    }

    @GetMapping("/search")
    public ResponseEntity<List<Store>> searchStoreByName(@RequestParam String q) {
        return ResponseEntity.ok(storeService.searchStoresByName(q));
    }

    // WRITE operation

    @PostMapping
    public ResponseEntity<?> createNewStore(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                            @RequestBody StoreRequestEntity reqEntity) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> storeService.createNewStore(reqEntity),
                List.of(User.UserRole.ADMIN)
        );
    }

    @PostMapping("/dev/create-bulks")
    public ResponseEntity<?> createBulkStores(@RequestBody List<StoreRequestEntity> reqEntities) {
        return controllerWrapper(() -> storeService.createBulkStores(reqEntities));
    }

    // MODIFY operation

    @PostMapping("/{id}")
    public ResponseEntity<?> updateExistingStore(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                                 @PathVariable String id,
                                                 @RequestBody StoreRequestEntity reqEntity) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> storeService.updateExistingStore(id, reqEntity),
                List.of(User.UserRole.ADMIN)
        );
    }

    @PostMapping("/{id}/{fieldName}")
    public ResponseEntity<?> updateFieldValueOfExistingStore(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                                             @PathVariable String id,
                                                             @PathVariable String fieldName,
                                                             @RequestBody Object newValue) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> storeService.updateFieldValueOfExistingStore(id, fieldName, newValue),
                List.of(User.UserRole.ADMIN)
        );
    }

    // DELETE operation

    @DeleteMapping("/dev/all")
    public ResponseEntity<?> removeAllStores(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                storeService::removeAllStores,
                List.of(User.UserRole.ADMIN)
        );
    }

    @DeleteMapping("/dev/remove/duplicated")
    public ResponseEntity<?> removeStoreByDuplicatedName() {
        return controllerWrapper(() -> storeService.removeStoreByDuplicatedName());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> removeStoreById(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                             @PathVariable String id) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> storeService.removeStoreById(id),
                List.of(User.UserRole.ADMIN)
        );
    }

}
