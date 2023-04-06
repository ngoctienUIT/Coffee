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

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "imageUrl": image,
      "productIds": [],
    };
  }
}
