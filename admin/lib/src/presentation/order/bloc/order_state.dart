import '../../../domain/repositories/order/order_response.dart';

abstract class OrderState {}

class InitState extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final int index;
  final List<OrderResponse> listOrder;

  OrderLoaded(this.index, this.listOrder);
}

class OrderError extends OrderState {
  final String? message;
  OrderError(this.message);
}

class RefreshLoading extends OrderState {}

class RefreshLoaded extends OrderState {
  final int index;
  final List<OrderResponse> listOrder;

  RefreshLoaded(this.index, this.listOrder);
}

class RefreshError extends OrderState {
  final String? message;
  RefreshError(this.message);
}
