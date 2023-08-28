import 'package:coffee_admin/src/data/models/product_catalogues.dart';

class ProductCataloguesRequest {
  ProductCatalogues productCatalogues;
  String image;

  ProductCataloguesRequest({
    required this.image,
    required this.productCatalogues,
  });
}
