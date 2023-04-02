import '../../../domain/repositories/order/order_response.dart';

abstract class CartState {}

class InitState extends CartState {}

class GetOrderSuccessState extends CartState {
  OrderResponse? order;

  GetOrderSuccessState(this.order);
}

class GetOrderErrorState extends CartState {
  String error;

  GetOrderErrorState(this.error);
}

class GetOrderLoadingState extends CartState {}

class RemoveOrderSuccessState extends CartState {}

class RemoveOrderLoadingState extends CartState {}

class RemoveOrderErrorState extends CartState {
  String error;

  RemoveOrderErrorState(this.error);
}
