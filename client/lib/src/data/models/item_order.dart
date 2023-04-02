import '../../domain/repositories/item_order/item_order_response.dart';

class ItemOrder {
  String productId;
  int quantity;
  List<String> toppingIds;
  int selectedSize;

  ItemOrder({
    required this.productId,
    required this.quantity,
    required this.toppingIds,
    required this.selectedSize,
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
      toppingIds: [],
      selectedSize: itemOrder.selectedSize == "S"
          ? 0
          : (itemOrder.selectedSize == "M" ? 1 : 2),
    );
  }
}
