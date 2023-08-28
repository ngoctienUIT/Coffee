import 'package:coffee_admin/src/data/remote/response/product_catalogues/product_catalogues_response.dart';

class ProductCatalogues {
  String? id;
  String name;
  String description;
  String? image;

  ProductCatalogues({
    this.id,
    required this.name,
    required this.description,
    this.image,
  });

  factory ProductCatalogues.fromResponse(ProductCataloguesResponse catalogues) {
    return ProductCatalogues(
      name: catalogues.name,
      description: catalogues.description,
      id: catalogues.id,
      image: catalogues.image,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "imageUrl": image,
      "productIds": [],
    };
  }
}
