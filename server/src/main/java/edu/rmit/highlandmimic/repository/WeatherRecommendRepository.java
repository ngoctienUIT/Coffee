package edu.rmit.highlandmimic.repository;

import edu.rmit.highlandmimic.model.WeatherRecommend;
import java.util.List;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

public interface WeatherRecommendRepository extends MongoRepository<WeatherRecommend, String> {

  @Query("{'weather': ?0, $or: [{'minTemp': null, 'maxTemp': {$gte: ?1}}, {'minTemp': {$lte: ?1}, 'maxTemp': null}, {'minTemp': {$lte: ?1}, 'maxTemp': {$gte: ?1}}]}")
  List<WeatherRecommend> findByWeatherAndTemperature(WeatherRecommend.Weather weather, double temperature);
}
