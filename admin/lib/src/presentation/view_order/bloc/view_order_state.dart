import '../../../domain/entities/user/user_response.dart';
import '../../../domain/repositories/order/order_response.dart';

abstract class ViewOrderState {}

class InitState extends ViewOrderState {}

class LoadingState extends ViewOrderState {}

class CancelSuccessState extends ViewOrderState {}

class CompletedSuccessState extends ViewOrderState {}

class GetOrderSuccessState extends ViewOrderState {
  UserResponse user;
  OrderResponse order;

  GetOrderSuccessState(this.user, this.order);
}

class ErrorState extends ViewOrderState {
  String error;

  ErrorState(this.error);
}
