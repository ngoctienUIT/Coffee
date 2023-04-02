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
