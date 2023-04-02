// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_order_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemOrderEntity _$ItemOrderEntityFromJson(Map<String, dynamic> json) =>
    ItemOrderEntity(
      productId: json['productId'] as String?,
      quantity: json['quantity'] as int?,
      toppingIds: (json['toppingIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      selectedSize: json['selectedSize'] as String?,
    );

Map<String, dynamic> _$ItemOrderEntityToJson(ItemOrderEntity instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'quantity': instance.quantity,
      'toppingIds': instance.toppingIds,
      'selectedSize': instance.selectedSize,
    };
