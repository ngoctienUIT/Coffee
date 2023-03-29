// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topping_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToppingResponse _$ToppingResponseFromJson(Map<String, dynamic> json) =>
    ToppingResponse(
      toppingId: json['toppingId'] as String,
      toppingName: json['toppingName'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      pricePerService: json['pricePerService'] as int,
    );

Map<String, dynamic> _$ToppingResponseToJson(ToppingResponse instance) =>
    <String, dynamic>{
      'toppingId': instance.toppingId,
      'toppingName': instance.toppingName,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'pricePerService': instance.pricePerService,
    };
