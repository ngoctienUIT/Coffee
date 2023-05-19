import 'package:coffee/src/core/utils/enum/enums.dart';

import '../../../data/models/order.dart';

abstract class CartState {}

class InitState extends CartState {}

class ChangeStoreState extends CartState {}

class GetOrderSuccessState extends CartState {
  Order? order;
  OrderStatus? status;
  bool isLoading;

  GetOrderSuccessState(this.order, [this.status, this.isLoading = true]);
}

class GetOrderErrorState extends CartState {
  String error;

  GetOrderErrorState(this.error);
}

class GetOrderLoadingState extends CartState {}
