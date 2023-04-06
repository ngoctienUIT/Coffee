import '../../../data/models/product_catalogues.dart';

abstract class AddProductCataloguesEvent {}

class CreateProductCataloguesEvent extends AddProductCataloguesEvent {
  ProductCatalogues productCatalogues;

  CreateProductCataloguesEvent(this.productCatalogues);
}

class ChangeImageEvent extends AddProductCataloguesEvent {
  String image;

  ChangeImageEvent(this.image);
}

class SaveButtonEvent extends AddProductCataloguesEvent {
  bool isContinue;

  SaveButtonEvent(this.isContinue);
}

class UpdateProductCataloguesEvent extends AddProductCataloguesEvent {
  ProductCatalogues productCatalogues;

  UpdateProductCataloguesEvent(this.productCatalogues);
}
