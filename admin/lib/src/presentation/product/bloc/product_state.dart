import '../../../data/remote/response/product/product_response.dart';
import '../../../data/remote/response/product_catalogues/product_catalogues_response.dart';

abstract class ProductState {}

class InitState extends ProductState {}

class ProductLoading extends ProductState {
  bool check;

  ProductLoading([this.check = true]);
}

class ProductLoaded extends ProductState {
  final int index;
  final List<ProductResponse> listProduct;
  final List<ProductCataloguesResponse> listProductCatalogues;

  ProductLoaded(this.index, this.listProduct, this.listProductCatalogues);
}

class ProductError extends ProductState {
  final String? message;
  ProductError(this.message);
}

class RefreshLoading extends ProductState {}

class RefreshLoaded extends ProductState {
  final int index;
  final List<ProductResponse> listProduct;
  final bool check;

  RefreshLoaded(this.index, this.listProduct, [this.check = true]);
}
