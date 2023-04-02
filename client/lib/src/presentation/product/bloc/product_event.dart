import '../../../data/models/product.dart';

abstract class ProductEvent {}

class DataTransmissionEvent extends ProductEvent {
  final Product product;

  DataTransmissionEvent({required this.product});
}

class AddProductToOrderEvent extends ProductEvent {
  final Product product;

  AddProductToOrderEvent(this.product);
}

class UpdateProductEvent extends ProductEvent {
  Product product;
  int index;

  UpdateProductEvent(this.product, this.index);
}

class DeleteProductEvent extends ProductEvent {
  int index;

  DeleteProductEvent(this.index);
}
