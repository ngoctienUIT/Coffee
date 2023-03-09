class Product {
  String name;
  String describe;
  String image;
  int price;
  int? quantity;
  String? note;

  Product({
    required this.name,
    required this.describe,
    required this.price,
    required this.image,
    this.quantity,
    this.note,
  });
}
