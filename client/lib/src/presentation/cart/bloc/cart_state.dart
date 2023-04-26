import 'package:coffee/src/core/utils/enum/enums.dart';

import '../../../domain/repositories/order/order_response.dart';

abstract class CartState {}

class InitState extends CartState {}

class AddNoteError extends CartState {
  String error;

  AddNoteError(this.error);
}

class GetOrderSuccessState extends CartState {
  OrderResponse? order;
  OrderStatus? status;

  GetOrderSuccessState(this.order, [this.status]);
}

class GetOrderErrorState extends CartState {
  String error;

  GetOrderErrorState(this.error);
}

class GetOrderLoadingState extends CartState {}
