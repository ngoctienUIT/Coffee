package edu.rmit.highlandmimic.model;

import java.util.List;
import lombok.Builder;
import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Data
@Builder
@Document("weather-recommend")
public class WeatherRecommend {

  @Id
  private String weatherRecommendId;

  private List<Tag> tags;

  private Double minTemp;

  private Double maxTemp;

  private Weather weather;

  public enum Weather {
    RAIN,
    SNOW,
    CLEAR,
    CLOUDS
  }
}
