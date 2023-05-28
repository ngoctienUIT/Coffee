package edu.rmit.highlandmimic.common;

import edu.rmit.highlandmimic.model.*;

import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

public class ModelMappingHandlers {

    public static <T, U, Y> Boolean verifyAssociation(String existingSourceId,
                                                List<T> checkingDependencies,
                                                Function<T, Optional<U>> nullGuardian,
                                                Function<? super U, ? extends Y> mappingFunction) {
        return checkingDependencies.stream()
                .anyMatch(dependency -> nullGuardian.apply(dependency)
                        .map(mappingFunction)
                        .map(associatedId -> associatedId.toString().equalsIgnoreCase(existingSourceId))
                        .orElse(false)
                );
    }

    // You have a List<A>, but A contains a List<B> => you have a List<List<B>> (after map: TransformMapping)
    // then, you flat a whole list of B into a single list of B => List<B> (after flat)
    // B contains a singular element of C, => List<C> (after map: PointingMapping)
    public static <A, B, C> Set<? extends C> mergeElementsOfSublistIntoASingleSet(List<A> containers,
                                                                                   Function<? super A, ? extends List<B>> transformMapper,
                                                                                   Function<? super B, ? extends C> pointingMapper) {
        return containers.stream()
                .map(transformMapper)
                .flatMap(List::stream)
                .map(pointingMapper)
                .collect(Collectors.toSet());
    }

    public static <T, U, Y> void associationGuardianBeforeTakingAction(String existingSourceId,
                                                List<T> checkingDependencies,
                                                Function<T, Optional<U>> nullGuardian,
                                                Function<? super U,? extends Y> mappingFunction) {
        boolean isAssociated = verifyAssociation(existingSourceId, checkingDependencies, nullGuardian, mappingFunction);
        if (isAssociated) {
            throw new UnsupportedOperationException("Action is blocked due to existence of association of object id:" + existingSourceId);
        }
    }

    public static List<ProductCatalogue> convertListOfIdsToCatalogues(List<ProductCatalogue> catalogues, List<String> catalogueIds) {
        return Optional.ofNullable(catalogueIds)
                .map(ids -> ids.stream().map(
                            idString -> catalogues.stream()
                                    .filter(catalogueDocument -> catalogueDocument.getProductCatalogueId().equals(idString))
                                    .findFirst()
                                    .orElseThrow(() -> new NoSuchElementException("There is no catalogue with id: " + idString + " in product-catalogues collection"))
                        ).toList()
                ).orElse(new ArrayList<>());
    }

    public static List<Topping> convertListOfIdsToToppings(List<Topping> toppings, List<String> toppingIds) {
        return Optional.ofNullable(toppingIds)
               .map(ids -> ids.stream().map(
                            idString -> toppings.stream()
                                   .filter(toppingDocument -> toppingDocument.getToppingId().equals(idString))
                                   .findFirst()
                                   .orElseThrow(() -> new NoSuchElementException("There is no topping with id: " + idString + " in toppings collection"))
                        ).toList()
                ).orElse(new ArrayList<>());
    }
    
    public static List<Tag> convertListOfIdsToTags(List<Tag> tags, List<String> tagIds) {
        return Optional.ofNullable(tagIds)
                .map(ids -> ids.stream().map(
                                idString -> tags.stream()
                                        .filter(toppingDocument -> toppingDocument.getTagId().equals(idString))
                                        .findFirst()
                                        .orElseThrow(() -> new NoSuchElementException("There is no topping with id: " + idString + " in toppings collection"))
                        ).toList()
                ).orElse(new ArrayList<>());
    }

    public static List<Product> convertListOfIdsToProducts(List<Product> referenceProducts, List<String> productIds) {
        return Optional.ofNullable(productIds)
              .map(ids -> ids.stream().map(
                        idString -> referenceProducts.stream()
                              .filter(productDocument -> productDocument.getProductId().equals(idString))
                              .findFirst()
                              .orElseThrow(() -> new NoSuchElementException("There is no product with id: " + idString + " in products collection"))
                        ).toList()
                ).orElse(new ArrayList<>());
    }

    public static List<Coupon> convertListOfIdsToCoupons(List<Coupon> referenceCoupons, List<String> coupons) {
        return Optional.ofNullable(coupons)
              .map(ids -> ids.stream().map(
                        idString -> referenceCoupons.stream()
                              .filter(couponDocument -> couponDocument.getId().equals(idString))
                              .findFirst()
                              .orElseThrow(() -> new NoSuchElementException("There is no coupon with id: " + idString + " in coupons collection"))
                        ).toList()
                ).orElse(new ArrayList<>());
    }
}
