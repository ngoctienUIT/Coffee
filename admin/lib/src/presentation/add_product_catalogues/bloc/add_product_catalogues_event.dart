import 'package:equatable/equatable.dart';

import '../../../data/models/product_catalogues.dart';

abstract class AddProductCataloguesEvent extends Equatable {}

class CreateProductCataloguesEvent extends AddProductCataloguesEvent {
  final ProductCatalogues productCatalogues;

  CreateProductCataloguesEvent(this.productCatalogues);

  @override
  List<Object?> get props => [productCatalogues];
}

class ChangeImageEvent extends AddProductCataloguesEvent {
  final String image;

  ChangeImageEvent(this.image);

  @override
  List<Object?> get props => [image];
}

class SaveButtonEvent extends AddProductCataloguesEvent {
  final bool isContinue;

  SaveButtonEvent(this.isContinue);

  @override
  List<Object?> get props => [isContinue];
}

class UpdateProductCataloguesEvent extends AddProductCataloguesEvent {
  final ProductCatalogues productCatalogues;

  UpdateProductCataloguesEvent(this.productCatalogues);

  @override
  List<Object?> get props => [productCatalogues];
}
