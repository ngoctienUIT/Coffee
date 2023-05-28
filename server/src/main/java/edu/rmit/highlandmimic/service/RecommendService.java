package edu.rmit.highlandmimic.service;

import static edu.rmit.highlandmimic.common.ModelMappingHandlers.convertListOfIdsToTags;

import com.fasterxml.jackson.core.JsonProcessingException;
import edu.rmit.highlandmimic.model.Product;
import edu.rmit.highlandmimic.model.WeatherRecommend;
import edu.rmit.highlandmimic.model.WeatherRecommend.Weather;
import edu.rmit.highlandmimic.model.request.WeatherRecommendRequestEntity;
import edu.rmit.highlandmimic.model.response.WeatherDTO;
import edu.rmit.highlandmimic.repository.WeatherRecommendRepository;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class RecommendService {

  private final WeatherService weatherService;
  private final ProductService productService;
  private final WeatherRecommendRepository weatherRecommendRepository;
  private final TagService tagService;

  public List<Product> getRecommendedProducts(double lat, double lon)
      throws JsonProcessingException {
    WeatherDTO currentWeather = weatherService.getWeather(lat, lon);
    String weatherStatus = currentWeather.getMain().toUpperCase();
    WeatherRecommend.Weather weather = Weather.valueOf(weatherStatus);
    double temperature = currentWeather.getTemperature();
    List<WeatherRecommend> weatherRecommends = weatherRecommendRepository.findByWeatherAndTemperature(
        weather, temperature);
    Set<String> tagIds = new HashSet<>();
    weatherRecommends.forEach(w -> w.getTags().forEach(t -> tagIds.add(t.getTagId())));
    return productService.getProductsByTagIds(tagIds);
  }

  public WeatherRecommend createNewWeatherRecommend(WeatherRecommendRequestEntity request)
      throws RuntimeException {
    if (request.getTagIds().isEmpty()) {
      throw new RuntimeException("Tags required");
    }
    return weatherRecommendRepository.save(WeatherRecommend.builder()
        .tags(convertListOfIdsToTags(this.tagService.getAllTags(), request.getTagIds()))
        .minTemp(request.getMinTemp()).maxTemp(request.getMaxTemp()).weather(request.getWeather())
        .build());
  }

  public List<WeatherRecommend> getWeatherRecommends() {
    return weatherRecommendRepository.findAll();
  }

  public WeatherRecommend deleteRecommend(String weatherRecommendId) {
    Optional<WeatherRecommend> weatherRecommendOptional = weatherRecommendRepository.findById(
        weatherRecommendId);
    if (weatherRecommendOptional.isPresent()) {
      WeatherRecommend weatherRecommend = weatherRecommendOptional.get();
      weatherRecommendRepository.deleteById(weatherRecommendId);
      return weatherRecommend;
    } else {
      return null;
    }
  }

  public WeatherRecommend updateRecommend(String weatherRecommendId,
      WeatherRecommendRequestEntity request) {
    WeatherRecommend weatherRecommend = weatherRecommendRepository.findById(weatherRecommendId)
        .orElseThrow(null);
    if (weatherRecommend == null) {
      return null;
    }
    weatherRecommend.setTags(
        convertListOfIdsToTags(this.tagService.getAllTags(), request.getTagIds()));
    weatherRecommend.setWeather(request.getWeather());
    weatherRecommend.setMinTemp(request.getMinTemp());
    weatherRecommend.setMaxTemp(request.getMaxTemp());
    return weatherRecommendRepository.save(weatherRecommend);
  }

  public WeatherRecommend deleteAll() {
    weatherRecommendRepository.deleteAll();
    return null;
  }
}
