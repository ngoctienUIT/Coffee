package edu.rmit.highlandmimic.service;

import edu.rmit.highlandmimic.model.Product;
import edu.rmit.highlandmimic.model.Tag;
import edu.rmit.highlandmimic.model.WeatherRecommend;
import edu.rmit.highlandmimic.model.request.TagRequestEntity;
import edu.rmit.highlandmimic.repository.TagRepository;
import lombok.SneakyThrows;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;

import java.lang.reflect.Field;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

import static edu.rmit.highlandmimic.common.ModelMappingHandlers.associationGuardianBeforeTakingAction;
import static edu.rmit.highlandmimic.common.ModelMappingHandlers.mergeElementsOfSublistIntoASingleSet;
import static java.util.Optional.ofNullable;

@Service
public class TagService {

    private final TagRepository tagRepository;

    private final ProductService productService;
    private final RecommendService recommendService;

    @Autowired
    private TagService(TagRepository tagRepository,
                       @Lazy ProductService productService,
                       @Lazy RecommendService recommendService) {
        this.tagRepository = tagRepository;
        this.productService = productService;
        this.recommendService = recommendService;
    }

    // READ operations

    public List<Tag> getAllTags() {
        return tagRepository.findAll();
    }

    public Tag getTagById(String id) {
        return tagRepository.findById(id).orElse(null);
    }

    public List<Tag> searchTagsByName(String nameQuery) {
        return tagRepository.getTagsByTagNameContains(nameQuery);
    }

    // WRITE operations

    public Tag createNewTag(TagRequestEntity reqEntity) {
        Tag preparedTag = Tag.builder()
                .tagName(reqEntity.getName())
                .tagDescription(reqEntity.getDescription())
                .tagColorCode(ofNullable(reqEntity.getColor()).orElse(Tag.generateRandomColorCode()))
                .build();

        return tagRepository.save(preparedTag);
    }

    // MODIFY operations

    public Tag updateExistingTag(String id, TagRequestEntity reqEntity) {

        Tag preparedTag = ofNullable(this.getTagById(id))
                .map(loadedEntity -> {
                    loadedEntity.setTagName(reqEntity.getName());
                    loadedEntity.setTagDescription(reqEntity.getDescription());
                    loadedEntity.setTagColorCode(reqEntity.getColor());

                    return loadedEntity;
                }).orElseThrow();

        return tagRepository.save(preparedTag);
    }

    @SneakyThrows
    public Tag updateFieldValueOfExistingTag(String id, String fieldName, Object newValue) {
        Tag preparedTag =  ofNullable(this.getTagById(id)).orElseThrow();

        Field preparedField = preparedTag.getClass().getDeclaredField(fieldName);
        preparedField.setAccessible(true);
        preparedField.set(preparedTag, newValue);

        return tagRepository.save(preparedTag);
    }


    // DELETE operations

    public Tag removeTagById(String id) {

        Objects.requireNonNull(this.getTagById(id));

        var tagsFromAllProducts = mergeElementsOfSublistIntoASingleSet(
                productService.getAllProducts(),
                Product::getTags,
                Tag::getTagId
        ).stream().toList();

        associationGuardianBeforeTakingAction(
                id, tagsFromAllProducts,
                Optional::of,
                Object::toString
        );

        var tagsFromAllWeatherRecommendations = mergeElementsOfSublistIntoASingleSet(
                recommendService.getWeatherRecommends(),
                WeatherRecommend::getTags,
                Tag::getTagId
        ).stream().toList();

        associationGuardianBeforeTakingAction(
                id, tagsFromAllWeatherRecommendations,
                Optional::of,
                Object::toString
        );

        return tagRepository.findById(id)
                .map(loadedEntity -> {
                    tagRepository.delete(loadedEntity);
                    return loadedEntity;
                }).orElseThrow();
    }

    public long removeAllTags() {
        long quantity = tagRepository.count();
        tagRepository.deleteAll();
        return quantity;
    }

}