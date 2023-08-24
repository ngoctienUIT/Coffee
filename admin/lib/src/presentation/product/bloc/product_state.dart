import 'package:equatable/equatable.dart';

import '../../../data/remote/response/product/product_response.dart';
import '../../../data/remote/response/product_catalogues/product_catalogues_response.dart';

abstract class ProductState extends Equatable {}

class InitState extends ProductState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ProductLoading extends ProductState {
  final bool check;

  ProductLoading([this.check = true]);

  @override
  List<Object?> get props => [check];
}

class ProductLoaded extends ProductState {
  final int index;
  final List<ProductResponse> listProduct;
  final List<ProductCataloguesResponse> listProductCatalogues;

  ProductLoaded(this.index, this.listProduct, this.listProductCatalogues);

  @override
  List<Object?> get props => [index, listProduct, listProductCatalogues];
}

class ProductError extends ProductState {
  final String? message;

  ProductError(this.message);

  @override
  List<Object?> get props => [message];
}

class RefreshLoading extends ProductState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class RefreshLoaded extends ProductState {
  final int index;
  final List<ProductResponse> listProduct;
  final bool check;

  RefreshLoaded(this.index, this.listProduct, [this.check = true]);

  @override
  List<Object?> get props => [index, listProduct, check];
}
