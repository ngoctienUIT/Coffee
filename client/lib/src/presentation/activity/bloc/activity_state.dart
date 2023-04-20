import '../../../domain/repositories/order/order_response.dart';

abstract class ActivityState {}

class InitState extends ActivityState {}

class ActivityLoading extends ActivityState {
  final int index;

  ActivityLoading(this.index);
}

class ActivityLoaded extends ActivityState {
  final List<OrderResponse> listOrder;
  final int index;

  ActivityLoaded({required this.listOrder, required this.index});
}

class ActivityError extends ActivityState {
  final String? message;
  final int index;

  ActivityError({this.message, required this.index});
}

class UpdateSuccess extends ActivityState {
  final List<OrderResponse> listOrder;
  final int index;

  UpdateSuccess(this.listOrder, this.index);
}
