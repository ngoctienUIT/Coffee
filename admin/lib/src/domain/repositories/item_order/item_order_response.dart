import 'package:json_annotation/json_annotation.dart';

import '../product/product_response.dart';
import '../topping/topping_response.dart';

part 'item_order_response.g.dart';

@JsonSerializable()
class ItemOrderResponse {
  @JsonKey(name: "product")
  ProductResponse product;

  @JsonKey(name: "quantity")
  int quantity;

  @JsonKey(name: "toppings")
  List<ToppingResponse> toppings;

  @JsonKey(name: "selectedSize")
  String selectedSize;

  ItemOrderResponse({
    required this.product,
    required this.quantity,
    required this.toppings,
    required this.selectedSize,
  });

  factory ItemOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ItemOrderResponseToJson(this);
}
