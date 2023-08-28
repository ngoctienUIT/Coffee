import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:coffee_admin/src/presentation/order/bloc/order_event.dart';
import 'package:coffee_admin/src/presentation/order/bloc/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/order_use_case/get_list_order.dart';

@injectable
class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetListOrderUseCase _getListOrderUseCase;

  OrderBloc(this._getListOrderUseCase) : super(InitState()) {
    on<FetchData>(_getData);

    on<RefreshData>((event, emit) => getDataOrder(true, event.index, emit));

    on<UpdateData>((event, emit) => getDataOrder(false, event.index, emit));

    on<ChangeOrderListEvent>(
        (event, emit) => emit(ChangeOrderListState(event.id)));
  }

  Future _getData(FetchData event, Emitter emit) async {
    emit(OrderLoading());
    final response = await _getListOrderUseCase.call(params: "PLACED");
    if (response is DataSuccess) {
      emit(OrderLoaded(0, response.data!));
    } else {
      emit(OrderError(response.error));
    }
  }

  Future getDataOrder(bool check, int index, Emitter emit) async {
    if (check) emit(OrderLoading());
    String status = index == 3
        ? ""
        : (index == 0 ? "PLACED" : (index == 1 ? "COMPLETED" : "CANCELLED"));
    final response = await _getListOrderUseCase.call(params: status);
    if (response is DataSuccess) {
      emit(OrderLoaded(0, response.data!));
    } else {
      emit(OrderError(response.error));
    }
  }
}
