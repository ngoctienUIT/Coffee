import 'package:coffee/src/core/utils/enum/enums.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/order.dart';

abstract class CartState extends Equatable {}

class InitState extends CartState {
  @override
  List<Object?> get props => [];
}

class ChangeStoreCartState extends CartState {
  @override
  List<Object?> get props => [];
}

class GetOrderLoadingState extends CartState {
  @override
  List<Object?> get props => [];
}

class GetOrderSuccessState extends CartState {
  final Order? order;
  final OrderStatus? status;
  final bool isLoading;

  GetOrderSuccessState(this.order, [this.status, this.isLoading = true]);

  @override
  List<Object?> get props => [order, status, isLoading];
}

class GetOrderErrorState extends CartState {
  final String error;

  GetOrderErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
