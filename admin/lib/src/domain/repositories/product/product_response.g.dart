// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductResponse _$ProductResponseFromJson(Map<String, dynamic> json) =>
    ProductResponse(
      image: json['imageUrl'] as String?,
      description: json['description'] as String?,
      id: json['productId'] as String,
      name: json['productName'] as String,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => TagResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      price: json['price'] as int,
      currency: json['currency'] as String,
      toppingOptions: (json['toppingOptions'] as List<dynamic>?)
          ?.map((e) => ToppingResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      upsizeOptions:
          UpsizeEntity.fromJson(json['upsizeOptions'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductResponseToJson(ProductResponse instance) =>
    <String, dynamic>{
      'productId': instance.id,
      'productName': instance.name,
      'price': instance.price,
      'currency': instance.currency,
      'imageUrl': instance.image,
      'description': instance.description,
      'toppingOptions': instance.toppingOptions,
      'tags': instance.tags,
      'upsizeOptions': instance.upsizeOptions,
    };
