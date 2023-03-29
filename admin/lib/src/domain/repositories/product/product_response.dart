import 'package:json_annotation/json_annotation.dart';

import '../../entities/upsize/upsize_entity.dart';

part 'product_response.g.dart';

@JsonSerializable()
class ProductResponse {
  @JsonKey(name: "productId")
  final String id;

  @JsonKey(name: "productName")
  final String name;

  @JsonKey(name: "price")
  final int price;

  @JsonKey(name: "currency")
  final String currency;

  @JsonKey(name: "imageUrl")
  final String? image;

  @JsonKey(name: "description")
  final String? description;

  @JsonKey(name: "toppingOptions")
  final List<String> toppingOptions;

  @JsonKey(name: "tags")
  final List<String> tags;

  @JsonKey(name: "upsizeOptions")
  final UpsizeEntity upsizeOptions;

  ProductResponse({
    this.image,
    this.description,
    required this.id,
    required this.name,
    required this.tags,
    required this.price,
    required this.currency,
    required this.toppingOptions,
    required this.upsizeOptions,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}
