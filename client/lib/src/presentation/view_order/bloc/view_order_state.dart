import 'package:coffee/src/domain/repositories/order/order_response.dart';

abstract class ViewOrderState {}

class InitState extends ViewOrderState {}

class ViewOrderLoading extends ViewOrderState {}

class ViewOrderSuccess extends ViewOrderState {
  OrderResponse order;

  ViewOrderSuccess(this.order);
}

class CancelOrderSuccess extends ViewOrderState {}

class ViewOrderError extends ViewOrderState {
  String error;

  ViewOrderError(this.error);
}
