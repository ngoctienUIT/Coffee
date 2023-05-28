package edu.rmit.highlandmimic.model.request;

import edu.rmit.highlandmimic.model.WeatherRecommend;
import java.util.List;
import lombok.Data;

@Data
public class WeatherRecommendRequestEntity {

  private List<String> tagIds;

  private Double minTemp;

  private Double maxTemp;

  private WeatherRecommend.Weather weather;
}
