// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommend_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendResponse _$RecommendResponseFromJson(Map<String, dynamic> json) =>
    RecommendResponse(
      id: json['weatherRecommendId'] as String?,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => TagResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      minTemp: (json['minTemp'] as num?)?.toDouble(),
      maxTemp: (json['maxTemp'] as num?)?.toDouble(),
      weather: json['weather'] as String?,
    );

Map<String, dynamic> _$RecommendResponseToJson(RecommendResponse instance) =>
    <String, dynamic>{
      'weatherRecommendId': instance.id,
      'tags': instance.tags,
      'minTemp': instance.minTemp,
      'maxTemp': instance.maxTemp,
      'weather': instance.weather,
    };
