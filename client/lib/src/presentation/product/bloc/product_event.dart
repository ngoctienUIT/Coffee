import 'package:equatable/equatable.dart';

import '../../../data/models/product.dart';

abstract class ProductEvent extends Equatable {}

class DataTransmissionEvent extends ProductEvent {
  final Product product;

  DataTransmissionEvent({required this.product});

  @override
  List<Object?> get props => [product];
}

class AddProductToOrderEvent extends ProductEvent {
  final Product product;

  AddProductToOrderEvent(this.product);

  @override
  List<Object?> get props => [product];
}

class UpdateProductEvent extends ProductEvent {
  final Product product;
  final int index;

  UpdateProductEvent(this.product, this.index);

  @override
  List<Object?> get props => [product, index];
}

class DeleteProductEvent extends ProductEvent {
  final int index;

  DeleteProductEvent(this.index);

  @override
  List<Object?> get props => [index];
}
