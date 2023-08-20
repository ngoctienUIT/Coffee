import '../../../data/remote/response/product/product_response.dart';

abstract class SearchState {}

class InitState extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<ProductResponse> listProduct;

  SearchLoaded(this.listProduct);
}

class SearchError extends SearchState {
  final String? message;

  SearchError(this.message);
}
