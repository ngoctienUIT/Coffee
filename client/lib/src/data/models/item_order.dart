class ItemOrder {
  String productId;
  int quantity;
  List<String> toppingIds;
  String selectedSize;

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
      "selectedSize": selectedSize,
    };
  }
}
