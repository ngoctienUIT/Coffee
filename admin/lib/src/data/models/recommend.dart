import 'package:coffee_admin/src/domain/repositories/recommend/recommend_response.dart';

import 'tag.dart';

class Recommend {
  String? id;
  List<Tag>? tags;
  double? minTemp;
  double? maxTemp;
  String? weather;

  Recommend({
    this.id,
    this.tags,
    this.minTemp,
    this.maxTemp,
    this.weather,
  });

  factory Recommend.fromRecommendResponse(RecommendResponse response) {
    return Recommend(
      id: response.id,
      maxTemp: response.maxTemp,
      minTemp: response.maxTemp,
      tags: response.tags!.map((e) => Tag.fromTagResponse(e)).toList(),
      weather: response.weather,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'weatherRecommendId': id,
      'tagIds': tags!.map((e) => e.tagId).toList(),
      if (minTemp != null) 'minTemp': minTemp,
      if (maxTemp != null) 'maxTemp': maxTemp,
      'weather': weather,
    };
  }
}
