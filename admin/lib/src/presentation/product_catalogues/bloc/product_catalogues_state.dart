import 'package:equatable/equatable.dart';

import '../../../data/remote/response/product_catalogues/product_catalogues_response.dart';

abstract class ProductCataloguesState extends Equatable {}

class InitState extends ProductCataloguesState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class DeleteSuccess extends ProductCataloguesState {
  final String id;

  DeleteSuccess(this.id);

  @override
  List<Object?> get props => [id];
}

class ProductCataloguesLoading extends ProductCataloguesState {
  final bool check;

  ProductCataloguesLoading([this.check = true]);

  @override
  List<Object?> get props => [check];
}

class ProductCataloguesLoaded extends ProductCataloguesState {
  final List<ProductCataloguesResponse> listProductCatalogues;

  ProductCataloguesLoaded(this.listProductCatalogues);

  @override
  List<Object?> get props => [listProductCatalogues];
}

class ProductCataloguesError extends ProductCataloguesState {
  final String? message;

  ProductCataloguesError(this.message);

  @override
  List<Object?> get props => [message];
}
