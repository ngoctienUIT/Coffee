package edu.rmit.highlandmimic.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import edu.rmit.highlandmimic.model.response.WeatherDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
@RequiredArgsConstructor
public class WeatherService {

  private final RestTemplate restTemplate;

  private final ObjectMapper objectMapper;

  @Value("${openweather.api.key}")
  private String apiKey;

  public WeatherDTO getWeather(double lat, double lon) throws JsonProcessingException {
    String url = String.format(
        "https://api.openweathermap.org/data/2.5/weather?lat=%s&lon=%s&appid=%s", lat, lon, apiKey);
    String response = restTemplate.getForObject(url, String.class);

    JsonNode root = objectMapper.readTree(response);
    JsonNode weatherNode = root.path("weather").get(0);
    JsonNode mainNode = root.path("main");

    double temperatureInKelvin = mainNode.path("temp").asDouble();
    double temperatureInCelsius = kelvinToCelsius(temperatureInKelvin);

    return WeatherDTO.builder()
        .name(root.path("name").asText())
        .main(weatherNode.path("main").asText())
        .temperature(temperatureInCelsius)
        .build();
  }

  private double kelvinToCelsius(double kelvin) {
    return kelvin - 273.15;
  }
}
