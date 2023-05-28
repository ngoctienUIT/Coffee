package edu.rmit.highlandmimic.service;

import edu.rmit.highlandmimic.model.Order;
import edu.rmit.highlandmimic.model.Store;
import edu.rmit.highlandmimic.model.request.StoreRequestEntity;
import edu.rmit.highlandmimic.repository.StoreRepository;
import lombok.RequiredArgsConstructor;
import lombok.SneakyThrows;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;

import java.lang.reflect.Field;
import java.util.*;

import static edu.rmit.highlandmimic.common.ModelMappingHandlers.associationGuardianBeforeTakingAction;
import static edu.rmit.highlandmimic.common.ModelMappingHandlers.verifyAssociation;
import static java.util.Optional.ofNullable;

@Service
public class StoreService {

    private final StoreRepository storeRepository;
    private final OrderService orderService;

    @Autowired
    public StoreService(StoreRepository storeRepository, @Lazy OrderService orderService) {
        this.storeRepository = storeRepository;
        this.orderService = orderService;
    }

    public List<Store> getAllStores() {
        return storeRepository.findAll();
    }

    public List<Store> findStoresByStoreNameContainingIgnoreCase(String address4) {
        return storeRepository.getStoreByAddress4(address4);
    }

    public Store getStoreById(String id) {
        return storeRepository.findById(id).orElse(null);
    }

    public List<Store> searchStoresByName(String nameQuery) {
        return storeRepository.findStoresByStoreNameContainingIgnoreCase(nameQuery);
    }

    public Store createNewStore(StoreRequestEntity reqEntity) {
        Store preparedStore = Store.builder()
                .storeName(reqEntity.getName())
                .address1(reqEntity.getAddress1())
                .address2(reqEntity.getAddress2())
                .address3(reqEntity.getAddress3())
                .address4(reqEntity.getAddress4())
                .latitude(reqEntity.getLatitude())
                .longitude(reqEntity.getLongitude())
                .imageUrl(reqEntity.getImageUrl())
                .hotlineNumber(reqEntity.getHotlineNumber())
                .build();

        return storeRepository.save(preparedStore);
    }

    // MODIFY operations

    public Store updateExistingStore(String id, StoreRequestEntity reqEntity) {

        Store preparedStore = ofNullable(this.getStoreById(id))
                .map(loadedEntity -> {
                    loadedEntity.setStoreName(reqEntity.getName());
                    loadedEntity.setAddress1(reqEntity.getAddress1());
                    loadedEntity.setAddress2(reqEntity.getAddress2());
                    loadedEntity.setAddress3(reqEntity.getAddress3());
                    loadedEntity.setAddress4(reqEntity.getAddress4());
                    loadedEntity.setLatitude(reqEntity.getLatitude());
                    loadedEntity.setLongitude(reqEntity.getLongitude());
                    loadedEntity.setImageUrl(reqEntity.getImageUrl());
                    loadedEntity.setHotlineNumber(reqEntity.getHotlineNumber());
                    
                    return loadedEntity;
                }).orElseThrow();

        return storeRepository.save(preparedStore);
    }

    @SneakyThrows
    public Store updateFieldValueOfExistingStore(String id, String fieldName, Object newValue) {
        Store preparedStore =  ofNullable(this.getStoreById(id)).orElseThrow();

        Field preparedField = preparedStore.getClass().getDeclaredField(fieldName);
        preparedField.setAccessible(true);
        preparedField.set(preparedStore, newValue);

        return storeRepository.save(preparedStore);
    }

    // DELETE operations

    public Store removeStoreById(String id) {

        Objects.requireNonNull(storeRepository.findById(id));

        associationGuardianBeforeTakingAction(
                id, orderService.getOrdersOfUser("", ""),
                (order) -> Optional.ofNullable(((Order) order).getSelectedPickupStore()),
                Store::getStoreId
        );

        return storeRepository.findById(id)
                .map(project -> {
                    storeRepository.delete(project);
                    return project;
                }).orElseThrow();
    }

    public long removeAllStores() {
        long quantity = storeRepository.count();
        storeRepository.deleteAll();
        return quantity;
    }

    public long createBulkStores(List<StoreRequestEntity> reqEntities) {
        for (StoreRequestEntity entity : reqEntities) {
            createNewStore(entity);
        }
        return reqEntities.size();
    }

    public int removeStoreByDuplicatedName() {
        List<Store> stores = this.getAllStores();
        Set<String> storeNames = new HashSet<>();
        int counter = 0;
        for (Store store : stores) {
            if (storeNames.contains(store.getStoreName())) {
                this.removeStoreById(store.getStoreId());
                counter++;
            } else {
                storeNames.add(store.getStoreName());
            }
        }
        return counter;
    }
}
