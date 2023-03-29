import '../../../domain/repositories/order/order_response.dart';

abstract class ActivityState {}

class InitState extends ActivityState {}

class ActivityLoading extends ActivityState {}

class ActivityLoaded extends ActivityState {
  final List<OrderResponse> listOrder;
  ActivityLoaded({required this.listOrder});
}

class ActivityError extends ActivityState {
  final String? message;
  ActivityError(this.message);
}
