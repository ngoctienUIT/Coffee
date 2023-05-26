import '../../../data/models/user.dart';
import '../../../domain/repositories/order/order_response.dart';

abstract class ViewOrderState {}

class InitState extends ViewOrderState {}

class LoadingState extends ViewOrderState {}

class CancelSuccessState extends ViewOrderState {}

class CompletedSuccessState extends ViewOrderState {}

class GetOrderSuccessState extends ViewOrderState {
  User user;
  OrderResponse order;

  GetOrderSuccessState(this.user, this.order);
}

class ErrorState extends ViewOrderState {
  String error;

  ErrorState(this.error);
}
