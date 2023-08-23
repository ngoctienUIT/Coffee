import 'package:coffee/src/data/remote/response/product/product_response.dart';
import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {}

class InitState extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchLoading extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchLoaded extends SearchState {
  final List<ProductResponse> listProduct;

  SearchLoaded(this.listProduct);

  @override
  List<Object?> get props => [listProduct];
}

class SearchError extends SearchState {
  final String? message;

  SearchError(this.message);

  @override
  List<Object?> get props => [message];
}
