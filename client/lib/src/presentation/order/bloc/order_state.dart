import 'package:coffee/src/domain/repositories/product/product_response.dart';

import '../../../domain/repositories/order/order_response.dart';
import '../../../domain/repositories/product_catalogues/product_catalogues_response.dart';

abstract class OrderState {}

class InitState extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final int index;
  final List<ProductResponse> listProduct;
  final List<ProductCataloguesResponse> listProductCatalogues;
  final OrderResponse? order;

  OrderLoaded(
      this.index, this.listProduct, this.listProductCatalogues, this.order);
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

  AddProductToCartLoaded(this.order);
}

class AddProductToCartError extends OrderState {
  final String? message;
  AddProductToCartError(this.message);
}
