package edu.rmit.highlandmimic.controller;

import edu.rmit.highlandmimic.model.Product;
import edu.rmit.highlandmimic.model.User;
import edu.rmit.highlandmimic.model.request.ProductRequestEntity;
import edu.rmit.highlandmimic.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

import static edu.rmit.highlandmimic.common.ControllerUtils.controllerWrapper;

@RestController
@RequestMapping("/product")
@RequiredArgsConstructor
public class ProductController {

    private final ProductService productService;
    private final SecurityHandler securityHandler;

    // READ operations

    @GetMapping
    public ResponseEntity<List<Product>> getAllProducts() {
        return ResponseEntity.ok(productService.getAllProducts());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Product> getProductById(@PathVariable String id) {
        return ResponseEntity.ok(productService.getProductById(id));
    }

    @GetMapping("/search")
    public ResponseEntity<List<Product>> searchProductsByName(@RequestParam String q) {
        return ResponseEntity.ok(productService.searchProductsByName(q));
    }

    // WRITE operation

    @PostMapping
    public ResponseEntity<?> createNewProduct(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                              @RequestBody ProductRequestEntity reqEntity) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> productService.createNewProduct(reqEntity),
                List.of(User.UserRole.ADMIN)
        );
    }

    // MODIFY operation

    @PostMapping("/{id}")
    public ResponseEntity<?> updateExistingProduct(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                                   @PathVariable String id,
                                                   @RequestBody ProductRequestEntity reqEntity) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> productService.updateExistingProduct(id, reqEntity),
                List.of(User.UserRole.ADMIN)
        );
    }

    @PostMapping("/{id}/{fieldName}")
    public ResponseEntity<?> updateFieldValueOfExistingProduct(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                                               @PathVariable String id,
                                                               @PathVariable String fieldName,
                                                               @RequestBody Object newValue) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> productService.updateFieldValueOfExistingProduct(id, fieldName, newValue),
                List.of(User.UserRole.ADMIN)
        );
    }

    @PostMapping("/{id}/upsizeOptions")
    public ResponseEntity<?> updateUpsizeOptionsOfExistingProduct(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                                                  @PathVariable String id,
                                                                  @RequestBody Map<String, Long> upsizeOptions) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> productService.updateUpsizeOptionsOfExistingProduct(id, upsizeOptions),
                List.of(User.UserRole.ADMIN)
        );
    }

    @PostMapping("/{id}/topping-options")
    public ResponseEntity<?> updateToppingOptions(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                                  @PathVariable String id,
                                                  @RequestBody List<String> toppingIds) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> productService.updateToppingOptions(id, toppingIds),
                List.of(User.UserRole.ADMIN)
        );
    }

    @PostMapping("/{id}/tags")
    public ResponseEntity<?> updateProductTags(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                               @PathVariable String id,
                                               @RequestBody List<String> tagIds) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> productService.updateProductTags(id, tagIds),
                List.of(User.UserRole.ADMIN)
        );
    }

    // DELETE operation

    @DeleteMapping("/dev/all")
    public ResponseEntity<?> removeAllProducts(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                productService::removeAllProducts,
                List.of(User.UserRole.ADMIN)
        );
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> removeProductById(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                               @PathVariable String id) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> productService.removeProductById(id),
                List.of(User.UserRole.ADMIN)
        );
    }

}