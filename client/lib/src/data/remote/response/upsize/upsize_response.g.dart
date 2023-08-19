// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upsize_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpsizeResponse _$UpsizeResponseFromJson(Map<String, dynamic> json) =>
    UpsizeResponse(
      s: json['S'] as int?,
      m: json['M'] as int,
      l: json['L'] as int,
    );

Map<String, dynamic> _$UpsizeResponseToJson(UpsizeResponse instance) =>
    <String, dynamic>{
      'S': instance.s,
      'M': instance.m,
      'L': instance.l,
    };
