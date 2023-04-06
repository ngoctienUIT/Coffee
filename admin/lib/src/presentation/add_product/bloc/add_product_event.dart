import '../../../data/models/product.dart';

abstract class AddProductEvent {}

class CreateProductEvent extends AddProductEvent {
  Product product;

  CreateProductEvent(this.product);
}

class ChangeImageEvent extends AddProductEvent {
  String image;

  ChangeImageEvent(this.image);
}

class ChangeCatalogueEvent extends AddProductEvent {
  String id;

  ChangeCatalogueEvent(this.id);
}

class SaveButtonEvent extends AddProductEvent {
  bool isContinue;

  SaveButtonEvent(this.isContinue);
}

class UpdateProductEvent extends AddProductEvent {
  Product product;

  UpdateProductEvent(this.product);
}
