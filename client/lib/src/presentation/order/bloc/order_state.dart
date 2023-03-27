import 'package:coffee/src/domain/repositories/product/product_response.dart';

abstract class OrderState {}

class InitState extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<ProductResponse> listProduct;
  OrderLoaded(this.listProduct);
}

class OrderError extends OrderState {
  final String? message;
  OrderError(this.message);
}
