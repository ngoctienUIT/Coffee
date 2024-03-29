import 'package:coffee_admin/src/data/remote/response/upsize/upsize_response.dart';
import 'package:json_annotation/json_annotation.dart';

import '../tag/tag_response.dart';
import '../topping/topping_response.dart';

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
  final List<ToppingResponse> toppingOptions;

  @JsonKey(name: "tags")
  final List<TagResponse> tags;

  @JsonKey(name: "upsizeOptions")
  final UpsizeResponse upsizeOptions;

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
