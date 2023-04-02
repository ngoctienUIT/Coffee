// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemOrderResponse _$ItemOrderResponseFromJson(Map<String, dynamic> json) =>
    ItemOrderResponse(
      product:
          ProductResponse.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
      toppings: (json['toppings'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      selectedSize: json['selectedSize'] as String,
    );

Map<String, dynamic> _$ItemOrderResponseToJson(ItemOrderResponse instance) =>
    <String, dynamic>{
      'product': instance.product,
      'quantity': instance.quantity,
      'toppings': instance.toppings,
      'selectedSize': instance.selectedSize,
    };
