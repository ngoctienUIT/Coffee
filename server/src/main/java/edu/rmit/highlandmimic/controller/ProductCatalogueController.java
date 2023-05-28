package edu.rmit.highlandmimic.controller;

import edu.rmit.highlandmimic.model.ProductCatalogue;
import edu.rmit.highlandmimic.model.User;
import edu.rmit.highlandmimic.model.request.CouponRequestEntity;
import edu.rmit.highlandmimic.model.request.ProductCatalogueRequestEntity;
import edu.rmit.highlandmimic.service.ProductCatalogueService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static edu.rmit.highlandmimic.common.ControllerUtils.controllerWrapper;

@RestController
@RequestMapping("/product-catalogues")
@RequiredArgsConstructor
public class ProductCatalogueController {

    private final ProductCatalogueService productCatalogueService;
    private final SecurityHandler securityHandler;

    // READ operations

    @GetMapping
    public ResponseEntity<List<ProductCatalogue>> getAllProductCatalogues() {
        return ResponseEntity.ok(productCatalogueService.getAllProductCatalogues());
    }

    @GetMapping("/{id}")
    public ResponseEntity<ProductCatalogue> getProductCatalogueById(@PathVariable String id) {
        return ResponseEntity.ok(productCatalogueService.getProductCatalogueById(id));
    }

    @GetMapping("/search")
    public ResponseEntity<List<ProductCatalogue>> searchProductCataloguesByName(@RequestParam String q) {
        return ResponseEntity.ok(productCatalogueService.searchProductCataloguesByName(q));
    }

    @GetMapping("/{id}/products")
    public ResponseEntity<?> getProductsOfProductCatalogueById(@PathVariable String id) {
        return controllerWrapper(() -> productCatalogueService.getProductsOfProductCatalogueById(id));
    }

    // WRITE operation

    @PostMapping
    public ResponseEntity<?> createNewProductCatalogue(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                                       @RequestBody ProductCatalogueRequestEntity reqEntity) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> productCatalogueService.createNewProductCatalogue(reqEntity),
                SecurityHandler.ALLOW_AUTHORITIES
        );
    }

    // MODIFY operation

    @PostMapping("/{id}")
    public ResponseEntity<?> updateExistingProductCatalogue(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                                            @PathVariable String id,
                                                            @RequestBody ProductCatalogueRequestEntity reqEntity) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> productCatalogueService.updateExistingProductCatalogue(id, reqEntity),
                SecurityHandler.ALLOW_AUTHORITIES
        );
    }

    @PostMapping("/{id}/{fieldName}")
    public ResponseEntity<?> updateFieldValueOfExistingProductCatalogue(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                                                        @PathVariable String id,
                                                                        @PathVariable String fieldName,
                                                                        @RequestBody Object newValue) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> productCatalogueService.updateFieldValueOfExistingProductCatalogue(id, fieldName, newValue),
                SecurityHandler.ALLOW_AUTHORITIES
        );
    }

    @PostMapping("/{id}/sub-catalogues")
    public ResponseEntity<?> updateSubCatalogues(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                                 @PathVariable String id,
                                                 @RequestBody List<String> productCatalogueIds) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> productCatalogueService.updateSubCatalogues(id, productCatalogueIds),
                SecurityHandler.ALLOW_AUTHORITIES
        );
    }

    @PostMapping("/{id}/products")
    public ResponseEntity<?> updateAssociatedProducts(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                                 @PathVariable String id,
                                                 @RequestBody List<String> productIds) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> productCatalogueService.updateAssociatedProducts(id, productIds),
                SecurityHandler.ALLOW_AUTHORITIES
        );
    }

    // DELETE operation

    @DeleteMapping("/dev/all")
    public ResponseEntity<?> removeAllProductCatalogues(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                productCatalogueService::removeAllProductCatalogues,
                List.of(User.UserRole.ADMIN)
        );
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> removeProductCatalogueById(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                                        @PathVariable String id) {
        return securityHandler.roleGuarantee(
                authorizationToken,
                () -> productCatalogueService.removeProductCatalogueById(id),
                SecurityHandler.ALLOW_AUTHORITIES
        );
    }

}
