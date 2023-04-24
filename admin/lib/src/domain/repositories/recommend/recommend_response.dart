import 'package:coffee_admin/src/domain/repositories/tag/tag_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recommend_response.g.dart';

@JsonSerializable()
class RecommendResponse {
  @JsonKey(name: "weatherRecommendId")
  String? id;

  @JsonKey(name: "tags")
  List<TagResponse>? tags;

  @JsonKey(name: "minTemp")
  double? minTemp;

  @JsonKey(name: "maxTemp")
  double? maxTemp;

  @JsonKey(name: "weather")
  String? weather;

  RecommendResponse({
    this.id,
    this.tags,
    this.minTemp,
    this.maxTemp,
    this.weather,
  });

  factory RecommendResponse.fromJson(Map<String, dynamic> json) =>
      _$RecommendResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendResponseToJson(this);
}
