import 'package:json_annotation/json_annotation.dart';

part 'item_order_entity.g.dart';

@JsonSerializable()
class ItemOrderEntity {
  @JsonKey(name: "productId")
  String? productId;

  @JsonKey(name: "quantity")
  int? quantity;

  @JsonKey(name: "toppingIds")
  List<String>? toppingIds;

  @JsonKey(name: "selectedSize")
  String? selectedSize;

  ItemOrderEntity({
    this.productId,
    this.quantity,
    this.toppingIds,
    this.selectedSize,
  });

  factory ItemOrderEntity.fromJson(Map<String, dynamic> json) =>
      _$ItemOrderEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ItemOrderEntityToJson(this);
}
