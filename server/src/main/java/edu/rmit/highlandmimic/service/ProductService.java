package edu.rmit.highlandmimic.service;

import static edu.rmit.highlandmimic.common.ModelMappingHandlers.associationGuardianBeforeTakingAction;
import static edu.rmit.highlandmimic.common.ModelMappingHandlers.convertListOfIdsToTags;
import static edu.rmit.highlandmimic.common.ModelMappingHandlers.convertListOfIdsToToppings;
import static edu.rmit.highlandmimic.common.ModelMappingHandlers.mergeElementsOfSublistIntoASingleSet;
import static java.util.Optional.ofNullable;

import edu.rmit.highlandmimic.model.Order;
import edu.rmit.highlandmimic.model.OrderItem;
import edu.rmit.highlandmimic.model.Product;
import edu.rmit.highlandmimic.model.ProductCatalogue;
import edu.rmit.highlandmimic.model.request.ProductRequestEntity;
import edu.rmit.highlandmimic.repository.ProductRepository;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.Set;
import lombok.SneakyThrows;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;

@Service
public class ProductService {

  private final ProductRepository productRepository;
  private final ToppingService toppingService;
  private final TagService tagService;

  private final OrderService orderService;

  private final ProductCatalogueService productCatalogueService;

  @Autowired
  public ProductService(ProductRepository productRepository,
      ToppingService toppingService,
      TagService tagService,
      @Lazy OrderService orderService,
      @Lazy ProductCatalogueService productCatalogueService) {
    this.productRepository = productRepository;
    this.toppingService = toppingService;
    this.tagService = tagService;
    this.orderService = orderService;
    this.productCatalogueService = productCatalogueService;
  }

  // READ operations

  public List<Product> getAllProducts() {
    return productRepository.findAll();
  }

  public Product getProductById(String id) {
    return productRepository.findById(id).orElse(null);
  }

  public List<Product> searchProductsByName(String nameQuery) {
    return productRepository.getProductsByProductNameContainsIgnoreCase(nameQuery);
  }

  // WRITE operations

  public Product createNewProduct(ProductRequestEntity reqEntity) {
    Product preparedProduct = Product.builder()
        .productName(reqEntity.getName())
        .price(reqEntity.getPrice())
        .imageUrl(reqEntity.getImageUrl())
        .description(reqEntity.getDescription())
        .upsizeOptions(reqEntity.getUpsizeOptions())
        .toppingOptions(convertListOfIdsToToppings(
            this.toppingService.getAllToppings(),
            reqEntity.getToppingIds()
        ))
        .tags(convertListOfIdsToTags(
            this.tagService.getAllTags(),
            reqEntity.getTagIds()
        ))
        .build();

    return productRepository.save(preparedProduct);
  }

  // MODIFY operations

  public Product updateExistingProduct(String id, ProductRequestEntity reqEntity) {

    Product preparedProduct = ofNullable(this.getProductById(id))
        .map(loadedEntity -> {
          loadedEntity.setProductName(reqEntity.getName());
          loadedEntity.setPrice(reqEntity.getPrice());
          loadedEntity.setImageUrl(reqEntity.getImageUrl());
          loadedEntity.setDescription(reqEntity.getDescription());
          loadedEntity.setUpsizeOptions(reqEntity.getUpsizeOptions());
          loadedEntity.setToppingOptions(convertListOfIdsToToppings(
              this.toppingService.getAllToppings(),
              reqEntity.getToppingIds()
          ));
          loadedEntity.setTags(convertListOfIdsToTags(
              this.tagService.getAllTags(),
              reqEntity.getTagIds()
          ));

          return loadedEntity;
        }).orElseThrow();

    return productRepository.save(preparedProduct);
  }

  @SneakyThrows
  public Product updateFieldValueOfExistingProduct(String id, String fieldName, Object newValue) {

    System.out.println(newValue.getClass().getName());

    Product preparedProduct = ofNullable(this.getProductById(id)).orElseThrow();

    Field preparedField = preparedProduct.getClass().getDeclaredField(fieldName);
    preparedField.setAccessible(true);
    preparedField.set(preparedProduct, (List.of("price").contains(fieldName))
        ? newValue
        : Long.valueOf(newValue.toString()));

    return productRepository.save(preparedProduct);
  }

  public Object updateToppingOptions(String id, List<String> toppingIds) {
    return productRepository.findById(id)
        .map(loadedEntity -> {
          loadedEntity.setToppingOptions(
              convertListOfIdsToToppings(toppingService.getAllToppings(), toppingIds)
          );

          productRepository.save(loadedEntity);
          return loadedEntity;
        }).orElseThrow();
  }

  public Product updateProductTags(String id, List<String> tagIds) {
    return productRepository.findById(id)
        .map(loadedEntity -> {
          loadedEntity.setTags(
              convertListOfIdsToTags(tagService.getAllTags(), tagIds)
          );

          productRepository.save(loadedEntity);
          return loadedEntity;
        }).orElseThrow();
  }

  // DELETE operations

  public Product removeProductById(String id) {

    Objects.requireNonNull(productRepository.findById(id));

    var productsFromAllOrders = mergeElementsOfSublistIntoASingleSet(
        orderService.getOrdersOfUser("", ""),
        Order::getOrderItems,
        OrderItem::getProduct
    ).stream().toList();

    associationGuardianBeforeTakingAction(
        id, productsFromAllOrders,
        Optional::of,
        Product::getProductId
    );

    var productIdsFromProductCatalogues = mergeElementsOfSublistIntoASingleSet(
        productCatalogueService.getAllProductCatalogues(),
        ProductCatalogue::getAssociatedProductIds,
        String::toString
    ).stream().toList();

    associationGuardianBeforeTakingAction(
        id, productIdsFromProductCatalogues,
        Optional::of,
        Object::toString
    );

    return productRepository.findById(id)
        .map(loadedEntity -> {
          productRepository.delete(loadedEntity);
          return loadedEntity;
        }).orElseThrow();
  }

  public long removeAllProducts() {
    long quantity = productRepository.count();
    productRepository.deleteAll();
    return quantity;
  }


  public Product updateUpsizeOptionsOfExistingProduct(String id, Map<String, Long> upsizeOptions) {
    return productRepository.findById(id)
        .map(loadedEntity -> {
          loadedEntity.setUpsizeOptions(upsizeOptions);
          productRepository.save(loadedEntity);
          return loadedEntity;
        }).orElseThrow();
  }

  public List<Product> getProductsByTagIds(Set<String> tagIds) {
    if (tagIds.isEmpty()) {
      return new ArrayList<>();
    }
    return productRepository.findByTagIds(tagIds);
  }
}