package edu.rmit.highlandmimic.controller;

import edu.rmit.highlandmimic.model.Topping;
import edu.rmit.highlandmimic.model.User;
import edu.rmit.highlandmimic.model.request.ToppingRequestEntity;
import edu.rmit.highlandmimic.service.ToppingService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static edu.rmit.highlandmimic.common.ControllerUtils.controllerWrapper;

@RestController
@RequestMapping("/topping")
@RequiredArgsConstructor
public class ToppingController {

    private final ToppingService toppingService;
    private final SecurityHandler securityHandler;

    // READ operations

    @GetMapping
    public ResponseEntity<List<Topping>> getAllToppings() {
        return ResponseEntity.ok(toppingService.getAllToppings());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Topping> getToppingById(@PathVariable String id) {
        return ResponseEntity.ok(toppingService.getToppingById(id));
    }

    @GetMapping("/search")
    public ResponseEntity<List<Topping>> searchToppingsByName(@RequestParam String q) {
        return ResponseEntity.ok(toppingService.searchToppingsByName(q));
    }

    // WRITE operation

    @PostMapping
    public ResponseEntity<?> createNewTopping(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                              @RequestBody ToppingRequestEntity reqEntity) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> toppingService.createNewTopping(reqEntity),
                SecurityHandler.ALLOW_AUTHORITIES
        );
    }

    // MODIFY operation

    @PostMapping("/{id}")
    public ResponseEntity<?> updateExistingTopping(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                                   @PathVariable String id,
                                                   @RequestBody ToppingRequestEntity reqEntity) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> toppingService.updateExistingTopping(id, reqEntity),
                SecurityHandler.ALLOW_AUTHORITIES
        );
    }

    @PostMapping("/{id}/{fieldName}")
    public ResponseEntity<?> updateFieldValueOfExistingTopping(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                                               @PathVariable String id,
                                                               @PathVariable String fieldName,
                                                               @RequestBody Object newValue) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> toppingService.updateFieldValueOfExistingTopping(id, fieldName, newValue),
                SecurityHandler.ALLOW_AUTHORITIES
        );
    }

    // DELETE operation

    @DeleteMapping("/dev/all")
    public ResponseEntity<?> removeAllToppings(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                toppingService::removeAllToppings,
                List.of(User.UserRole.ADMIN)
        );
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> removeToppingById(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                               @PathVariable String id) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> toppingService.removeToppingById(id),
                SecurityHandler.ALLOW_AUTHORITIES
        );
    }

}