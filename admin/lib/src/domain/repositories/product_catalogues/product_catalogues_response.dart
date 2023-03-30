import 'package:json_annotation/json_annotation.dart';

part 'product_catalogues_response.g.dart';

@JsonSerializable()
class ProductCataloguesResponse {
  @JsonKey(name: "productCatalogueId")
  final String id;

  @JsonKey(name: "productCatalogueName")
  final String name;

  @JsonKey(name: "description")
  final String description;

  @JsonKey(name: "imageUrl")
  final String image;

  @JsonKey(name: "subCatalogues")
  final List<String>? subCatalogues;

  ProductCataloguesResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    this.subCatalogues,
  });

  factory ProductCataloguesResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductCataloguesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCataloguesResponseToJson(this);
}
