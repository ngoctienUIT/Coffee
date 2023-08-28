import '../../../data/models/product.dart';

class ProductRequest {
  final Product product;
  final String image;
  final String? catalogueID;

  ProductRequest({
    required this.product,
    required this.image,
    this.catalogueID,
  });
}
