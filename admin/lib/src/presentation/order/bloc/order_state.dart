import 'package:equatable/equatable.dart';

import '../../../data/remote/response/order/order_response.dart';

abstract class OrderState extends Equatable {}

class InitState extends OrderState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class OrderLoading extends OrderState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class OrderLoaded extends OrderState {
  final int index;
  final List<OrderResponse> listOrder;

  OrderLoaded(this.index, this.listOrder);

  @override
  List<Object?> get props => [index, listOrder];
}

class OrderError extends OrderState {
  final String? message;

  OrderError(this.message);

  @override
  List<Object?> get props => [message];
}

class ChangeOrderListState extends OrderState {
  final String id;

  ChangeOrderListState(this.id);

  @override
  List<Object?> get props => [id];
}
