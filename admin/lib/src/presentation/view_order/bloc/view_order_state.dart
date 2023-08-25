import 'package:equatable/equatable.dart';

import '../../../data/models/user.dart';
import '../../../data/remote/response/order/order_response.dart';

abstract class ViewOrderState extends Equatable {}

class InitState extends ViewOrderState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class LoadingState extends ViewOrderState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class CancelSuccessState extends ViewOrderState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class CompletedSuccessState extends ViewOrderState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class GetOrderSuccessState extends ViewOrderState {
  final User user;
  final OrderResponse order;

  GetOrderSuccessState(this.user, this.order);

  @override
  List<Object?> get props => [user, order];
}

class ErrorState extends ViewOrderState {
  final String error;

  ErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
