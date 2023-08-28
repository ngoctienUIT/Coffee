import 'package:coffee/src/core/resources/data_state.dart';
import 'package:coffee/src/presentation/view_order/bloc/view_order_event.dart';
import 'package:coffee/src/presentation/view_order/bloc/view_order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/view_order_use_case/cancel_order.dart';
import '../../../domain/use_cases/view_order_use_case/get_order.dart';

@injectable
class ViewOrderBloc extends Bloc<ViewOrderEvent, ViewOrderState> {
  final GetOrderUserCase _getOrderUserCase;
  final CancelOrderUseCase _cancelOrderUseCase;

  ViewOrderBloc(this._getOrderUserCase, this._cancelOrderUseCase)
      : super(InitState()) {
    on<GetOrderEvent>(_getData);

    on<CancelOrderEvent>(_cancelOrder);
  }

  Future _getData(GetOrderEvent event, Emitter emit) async {
    emit(ViewOrderLoading());
    final response = await _getOrderUserCase.call(params: event.id);
    if (response is DataSuccess) {
      emit(ViewOrderSuccess(response.data!));
    } else {
      emit(ViewOrderError(response.error ?? ""));
    }
  }

  Future _cancelOrder(CancelOrderEvent event, Emitter emit) async {
    emit(ViewOrderLoading());
    final response = await _cancelOrderUseCase.call(params: event.id);
    if (response is DataSuccess) {
      emit(CancelOrderSuccess(event.id));
    } else {
      emit(ViewOrderError(response.error ?? ""));
    }
  }
}
