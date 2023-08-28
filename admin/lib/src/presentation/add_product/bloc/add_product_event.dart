import 'package:equatable/equatable.dart';

import '../../../data/models/product.dart';

abstract class AddProductEvent extends Equatable {}

class CreateProductEvent extends AddProductEvent {
  final Product product;

  CreateProductEvent(this.product);

  @override
  List<Object?> get props => [product];
}

class ChangeImageEvent extends AddProductEvent {
  final String image;

  ChangeImageEvent(this.image);

  @override
  List<Object?> get props => [image];
}

class ChangeCatalogueEvent extends AddProductEvent {
  final String id;

  ChangeCatalogueEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class SaveButtonEvent extends AddProductEvent {
  final bool isContinue;

  SaveButtonEvent(this.isContinue);

  @override
  List<Object?> get props => [isContinue];
}

class UpdateProductEvent extends AddProductEvent {
  final Product product;

  UpdateProductEvent(this.product);

  @override
  List<Object?> get props => [product];
}

class ChangeToppingEvent extends AddProductEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ChangeTagEvent extends AddProductEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}
