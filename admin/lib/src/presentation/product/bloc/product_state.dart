import '../../../domain/repositories/product/product_response.dart';
import '../../../domain/repositories/product_catalogues/product_catalogues_response.dart';

abstract class ProductState {}

class InitState extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductResponse> listProduct;
  final List<ProductCataloguesResponse> listProductCatalogues;

  ProductLoaded(this.listProduct, this.listProductCatalogues);
}

class ProductError extends ProductState {
  final String? message;
  ProductError(this.message);
}

class RefreshLoading extends ProductState {}

class RefreshLoaded extends ProductState {
  final List<ProductResponse> listProduct;

  RefreshLoaded(this.listProduct);
}

class RefreshError extends ProductState {
  final String? message;
  RefreshError(this.message);
}
