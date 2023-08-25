import 'package:coffee_admin/src/core/request/order_request/order_request.dart';
import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:coffee_admin/src/presentation/view_order/bloc/view_order_event.dart';
import 'package:coffee_admin/src/presentation/view_order/bloc/view_order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/order_use_case/cancel_order.dart';
import '../../../domain/use_cases/order_use_case/get_order_by_id.dart';
import '../../../domain/use_cases/order_use_case/order_completed.dart';

@injectable
class ViewOrderBloc extends Bloc<ViewOrderEvent, ViewOrderState> {
  final CancelOrderUseCase _cancelOrderUseCase;
  final OrderCompletedUseCase _orderCompletedUseCase;
  final GetOrderByIDUseCase _getOrderByIDUseCase;

  ViewOrderBloc(
    this._cancelOrderUseCase,
    this._orderCompletedUseCase,
    this._getOrderByIDUseCase,
  ) : super(InitState()) {
    on<CancelOrderEvent>(_cancelOrder);

    on<OrderCompletedEvent>(_orderCompleted);

    on<GetOrderEvent>(_getOrder);
  }

  Future _cancelOrder(CancelOrderEvent event, Emitter emit) async {
    emit(LoadingState());
    final response = await _cancelOrderUseCase.call(
        params: OrderRequest(id: event.id, userID: event.userID));
    if (response is DataSuccess) {
      emit(CancelSuccessState());
    } else {
      ErrorState(response.error ?? "");
    }
  }

  Future _orderCompleted(OrderCompletedEvent event, Emitter emit) async {
    emit(LoadingState());
    final response = await _orderCompletedUseCase.call(
        params: OrderRequest(id: event.id, userID: event.userID));
    if (response is DataSuccess) {
      emit(CompletedSuccessState());
    } else {
      ErrorState(response.error ?? "");
    }
  }

  Future _getOrder(GetOrderEvent event, Emitter emit) async {
    emit(LoadingState());
    final response = await _getOrderByIDUseCase.call(params: event.id);
    if (response is DataSuccess) {
      emit(GetOrderSuccessState(response.data!.user, response.data!.order));
    } else {
      ErrorState(response.error ?? "");
    }
  }
}
