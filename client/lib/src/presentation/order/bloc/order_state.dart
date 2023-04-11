import 'package:coffee/src/domain/repositories/product/product_response.dart';

import '../../../domain/repositories/order/order_response.dart';
import '../../../domain/repositories/product_catalogues/product_catalogues_response.dart';
import '../../../domain/repositories/store/store_response.dart';

abstract class OrderState {}

class InitState extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final int index;
  final List<ProductResponse> listProduct;
  final List<ProductCataloguesResponse> listProductCatalogues;
  final OrderResponse? order;
  final StoreResponse? store;
  final bool isBringBack;

  OrderLoaded({
    required this.index,
    required this.listProduct,
    required this.listProductCatalogues,
    this.order,
    this.store,
    required this.isBringBack,
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

class RefreshOrderError extends OrderState {
  final String? message;
  RefreshOrderError(this.message);
}

class AddProductToCartLoaded extends OrderState {
  final OrderResponse? order;
  final StoreResponse? store;
  final bool isBringBack;

  AddProductToCartLoaded(this.order, this.store, this.isBringBack);
}

class AddProductToCartError extends OrderState {
  final String? message;
  AddProductToCartError(this.message);
}
