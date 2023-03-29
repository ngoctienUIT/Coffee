// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagResponse _$TagResponseFromJson(Map<String, dynamic> json) => TagResponse(
      tagId: json['tagId'] as String,
      tagName: json['tagName'] as String?,
      tagDescription: json['tagDescription'] as String?,
      tagColorCode: json['tagColorCode'] as String?,
    );

Map<String, dynamic> _$TagResponseToJson(TagResponse instance) =>
    <String, dynamic>{
      'tagId': instance.tagId,
      'tagName': instance.tagName,
      'tagDescription': instance.tagDescription,
      'tagColorCode': instance.tagColorCode,
    };
