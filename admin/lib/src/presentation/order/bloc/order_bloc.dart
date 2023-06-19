import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:coffee_admin/src/presentation/order/bloc/order_event.dart';
import 'package:coffee_admin/src/presentation/order/bloc/order_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/preferences_model.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  PreferencesModel preferencesModel;

  OrderBloc(this.preferencesModel) : super(InitState()) {
    on<FetchData>((event, emit) => getData(emit));

    on<RefreshData>((event, emit) => getDataOrder(true, event.index, emit));

    on<UpdateData>((event, emit) => getDataOrder(false, event.index, emit));

    on<ChangeOrderListEvent>(
        (event, emit) => emit(ChangeOrderListState(event.id)));
  }

  Future getData(Emitter emit) async {
    try {
      emit(OrderLoading());
      final response = await preferencesModel.apiService
          .getAllOrders('Bearer ${preferencesModel.token}', "", "PLACED");
      final listOrder = response.data;
      listOrder.sort((a, b) => b.createdDate!
          .toDateTime2()
          .difference(a.createdDate!.toDateTime2())
          .inSeconds);
      emit(OrderLoaded(0, listOrder));
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(OrderError(error));
      print(error);
    } catch (e) {
      emit(OrderError(e.toString()));
      print(e);
    }
  }

  Future getDataOrder(bool check, int index, Emitter emit) async {
    try {
      if (check) emit(OrderLoading());
      String status = index == 3
          ? ""
          : (index == 0 ? "PLACED" : (index == 1 ? "COMPLETED" : "CANCELLED"));
      final response = await preferencesModel.apiService
          .getAllOrders('Bearer ${preferencesModel.token}', "", status);
      final listOrder = index != 3
          ? response.data
          : response.data
              .where((element) => element.orderStatus != "PENDING")
              .toList();
      listOrder.sort((a, b) => b.createdDate!
          .toDateTime2()
          .difference(a.createdDate!.toDateTime2())
          .inSeconds);

      emit(OrderLoaded(index, listOrder));
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(OrderError(error));
      print(error);
    } catch (e) {
      emit(OrderError(e.toString()));
      print(e);
    }
  }
}
