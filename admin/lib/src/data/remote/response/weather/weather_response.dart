import 'package:json_annotation/json_annotation.dart';

part 'weather_response.g.dart';

@JsonSerializable()
class WeatherResponse {
  @JsonKey(name: "name")
  final String name;

  @JsonKey(name: "main")
  final String main;

  @JsonKey(name: "temperature")
  final double temperature;

  WeatherResponse({
    required this.name,
    required this.main,
    required this.temperature,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherResponseToJson(this);
}
