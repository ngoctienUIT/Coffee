package edu.rmit.highlandmimic.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import edu.rmit.highlandmimic.model.Product;
import edu.rmit.highlandmimic.model.User;
import edu.rmit.highlandmimic.model.request.WeatherRecommendRequestEntity;
import edu.rmit.highlandmimic.model.response.WeatherDTO;
import edu.rmit.highlandmimic.service.RecommendService;
import edu.rmit.highlandmimic.service.WeatherService;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/recommendation")
@RequiredArgsConstructor
public class RecommendController {

  private final WeatherService weatherService;
  private final RecommendService recommendService;
  private final SecurityHandler securityHandler;

  @GetMapping("/weather")
  public ResponseEntity<WeatherDTO> getWeather(@RequestParam("lat") double lat,
                                               @RequestParam("lon") double lon) throws JsonProcessingException {
    return ResponseEntity.ok(weatherService.getWeather(lat, lon));
  }

  @GetMapping
  public ResponseEntity<List<Product>> getRecommendProducts(@RequestParam("lat") double lat,
                                                            @RequestParam("lon") double lon) throws JsonProcessingException {
    return ResponseEntity.ok(recommendService.getRecommendedProducts(lat, lon));
  }

  @PostMapping
  public ResponseEntity<?> createWeatherRecommend(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
                                                  @RequestBody WeatherRecommendRequestEntity request) {
    return securityHandler.roleGuarantee(
            authorizationToken,
            () -> recommendService.createNewWeatherRecommend(request),
            List.of(User.UserRole.ADMIN)
    );
  }

  @GetMapping("/list")
  public ResponseEntity<?> getWeatherRecommends(
      @RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken) {
    return securityHandler.roleGuarantee(authorizationToken, recommendService::getWeatherRecommends,
        List.of(User.UserRole.ADMIN));
  }

  @DeleteMapping("/{weatherRecommendId}")
  public ResponseEntity<?> deleteWeatherRecommend(
      @RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
      @PathVariable String weatherRecommendId) {
    return securityHandler.roleGuarantee(authorizationToken,
        () -> recommendService.deleteRecommend(weatherRecommendId), List.of(User.UserRole.ADMIN));
  }

  @PutMapping("/{weatherRecommendId}")
  public ResponseEntity<?> updateWeatherRecommend(
      @RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken,
      @PathVariable String weatherRecommendId, @RequestBody WeatherRecommendRequestEntity request) {
    return securityHandler.roleGuarantee(authorizationToken,
        () -> recommendService.updateRecommend(weatherRecommendId, request),
        List.of(User.UserRole.ADMIN));
  }

  @DeleteMapping("/all")
  public ResponseEntity<?> deleteAll(
      @RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationToken) {
    return securityHandler.roleGuarantee(authorizationToken,
        recommendService::deleteAll, List.of(User.UserRole.ADMIN));
  }
}
