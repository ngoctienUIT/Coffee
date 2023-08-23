import 'package:equatable/equatable.dart';

import '../../../data/remote/response/order/order_response.dart';

abstract class ActivityState extends Equatable {}

class InitState extends ActivityState {
  @override
  List<Object?> get props => [];
}

class ActivityLoading extends ActivityState {
  final int index;

  ActivityLoading(this.index);

  @override
  List<Object?> get props => [index];
}

class ActivityLoaded extends ActivityState {
  final List<OrderResponse> listOrder;
  final int index;

  ActivityLoaded({required this.listOrder, required this.index});

  @override
  List<Object?> get props => [index, listOrder];
}

class ActivityError extends ActivityState {
  final String? message;
  final int index;

  ActivityError({this.message, required this.index});

  @override
  List<Object?> get props => [index, message];
}

class UpdateSuccess extends ActivityState {
  final List<OrderResponse> listOrder;
  final int index;

  UpdateSuccess(this.listOrder, this.index);

  @override
  List<Object?> get props => [listOrder, index];
}
