import '../../../domain/repositories/product_catalogues/product_catalogues_response.dart';

abstract class ProductCataloguesState {}

class InitState extends ProductCataloguesState {}

class DeleteSuccess extends ProductCataloguesState {
  String id;

  DeleteSuccess(this.id);
}

class ProductCataloguesLoading extends ProductCataloguesState {
  bool check;

  ProductCataloguesLoading([this.check = true]);
}

class ProductCataloguesLoaded extends ProductCataloguesState {
  final List<ProductCataloguesResponse> listProductCatalogues;

  ProductCataloguesLoaded(this.listProductCatalogues);
}

class ProductCataloguesError extends ProductCataloguesState {
  final String? message;
  ProductCataloguesError(this.message);
}
