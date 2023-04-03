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

class DeleteProductLoadingState extends CartState {}

class DeleteProductSuccessState extends CartState {
  String id;

  DeleteProductSuccessState(this.id);
}

class DeleteProductErrorState extends CartState {
  String error;

  DeleteProductErrorState(this.error);
}

class PlaceOrderSuccessState extends CartState {}

class PlaceOrderLoadingState extends CartState {}

class PlaceOrderErrorState extends CartState {
  String error;

  PlaceOrderErrorState(this.error);
}
