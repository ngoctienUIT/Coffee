import 'package:coffee/src/data/remote/response/order/order_response.dart';

abstract class ViewOrderState {}

class InitState extends ViewOrderState {}

class ViewOrderLoading extends ViewOrderState {}

class ViewOrderSuccess extends ViewOrderState {
  OrderResponse order;

  ViewOrderSuccess(this.order);
}

class CancelOrderSuccess extends ViewOrderState {
  String id;

  CancelOrderSuccess(this.id);
}

class ViewOrderError extends ViewOrderState {
  String error;

  ViewOrderError(this.error);
}
