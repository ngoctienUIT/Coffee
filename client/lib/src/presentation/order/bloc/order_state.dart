import 'package:coffee/src/domain/repositories/product/product_response.dart';

import '../../../domain/repositories/product_catalogues/product_catalogues_response.dart';

abstract class OrderState {}

class InitState extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final int index;
  final List<ProductResponse> listProduct;
  final List<ProductCataloguesResponse> listProductCatalogues;

  OrderLoaded({
    required this.index,
    required this.listProduct,
    required this.listProductCatalogues,
  });
}

class OrderError extends OrderState {
  final String? message;

  OrderError(this.message);
}

class RefreshOrderLoading extends OrderState {}

class RefreshOrderLoaded extends OrderState {
  final List<ProductResponse> listProduct;
  final int index;

  RefreshOrderLoaded(this.index, this.listProduct);
}
