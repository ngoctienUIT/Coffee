import 'package:coffee/src/data/remote/response/product/product_response.dart';
import 'package:equatable/equatable.dart';

import '../../../data/remote/response/product_catalogues/product_catalogues_response.dart';

abstract class OrderState extends Equatable {}

class InitState extends OrderState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class OrderLoading extends OrderState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class OrderLoaded extends OrderState {
  final int index;
  final List<ProductResponse> listProduct;
  final List<ProductCataloguesResponse> listProductCatalogues;

  OrderLoaded({
    required this.index,
    required this.listProduct,
    required this.listProductCatalogues,
  });

  @override
  List<Object?> get props => [index, listProduct, listProductCatalogues];
}

class OrderError extends OrderState {
  final String? message;

  OrderError(this.message);

  @override
  List<Object?> get props => [message];
}

class RefreshOrderLoading extends OrderState {
  final int index;

  RefreshOrderLoading(this.index);

  @override
  List<Object?> get props => [index];
}

class RefreshOrderLoaded extends OrderState {
  final List<ProductResponse> listProduct;
  final int index;

  RefreshOrderLoaded(this.index, this.listProduct);

  @override
  List<Object?> get props => [listProduct, index];
}
