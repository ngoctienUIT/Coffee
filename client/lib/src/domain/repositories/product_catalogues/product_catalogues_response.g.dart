// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_catalogues_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductCataloguesResponse _$ProductCataloguesResponseFromJson(
        Map<String, dynamic> json) =>
    ProductCataloguesResponse(
      id: json['productCatalogueId'] as String,
      name: json['productCatalogueName'] as String,
      description: json['description'] as String,
      image: json['imageUrl'] as String,
      subCatalogues: (json['subCatalogues'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ProductCataloguesResponseToJson(
        ProductCataloguesResponse instance) =>
    <String, dynamic>{
      'productCatalogueId': instance.id,
      'productCatalogueName': instance.name,
      'description': instance.description,
      'imageUrl': instance.image,
      'subCatalogues': instance.subCatalogues,
    };
