import 'package:equatable/equatable.dart';

import '../../data/remote/response/item_order/item_order_response.dart';
import 'product.dart';
import 'topping.dart';

//ignore: must_be_immutable
class ItemOrder extends Equatable {
  String productId;
  int quantity;
  List<String> toppingIds;
  int selectedSize;
  Product? product;
  List<Topping>? toppings;

  ItemOrder({
    required this.productId,
    required this.quantity,
    required this.toppingIds,
    required this.selectedSize,
    this.product,
    this.toppings,
  });

  Map<String, dynamic> toJson() {
    return {
      "productId": productId,
      "quantity": quantity,
      "toppingIds": toppingIds,
      "selectedSize": selectedSize == 0 ? "S" : (selectedSize == 1 ? "M" : "L"),
    };
  }

  factory ItemOrder.fromItemOrderResponse(ItemOrderResponse itemOrder) {
    return ItemOrder(
      productId: itemOrder.product.id,
      quantity: itemOrder.quantity,
      toppingIds: itemOrder.toppings.map((e) => e.toppingId).toList(),
      selectedSize: itemOrder.selectedSize == "S"
          ? 0
          : (itemOrder.selectedSize == "M" ? 1 : 2),
      product: Product.fromProductResponse(itemOrder.product),
      toppings: itemOrder.toppings
          .map((e) => Topping.fromToppingResponse(e))
          .toList(),
    );
  }

  int getTotal() {
    int total = product!.price +
        (selectedSize == 0
            ? product!.S
            : (selectedSize == 1 ? product!.M : product!.L));
    for (var item in toppings!) {
      total += item.pricePerService;
    }
    return total * quantity;
  }

  @override
  List<Object?> get props => [
        productId,
        quantity,
        toppingIds,
        selectedSize,
      ];
}
