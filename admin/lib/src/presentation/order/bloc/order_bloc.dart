import 'package:coffee_admin/src/presentation/order/bloc/order_event.dart';
import 'package:coffee_admin/src/presentation/order/bloc/order_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/api_service.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(InitState()) {
    on<FetchData>((event, emit) => getData(emit));

    on<RefreshData>((event, emit) => getDataProduct(event.index, emit));
  }

  Future getData(Emitter emit) async {
    try {
      emit(OrderLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      final listOrder = await apiService.getAllOrders('Bearer $token', "", "");

      emit(OrderLoaded(0, listOrder));
    } catch (e) {
      emit(OrderError(e.toString()));
      print(e);
    }
  }

  Future getDataProduct(int index, Emitter emit) async {
    try {
      emit(RefreshLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String status = index == 0
          ? ""
          : (index == 1 ? "PLACED" : (index == 2 ? "COMPLETED" : "CANCELLED"));
      final listOrder =
          await apiService.getAllOrders('Bearer $token', "", status);

      emit(RefreshLoaded(index, listOrder));
    } catch (e) {
      emit(RefreshError(e.toString()));
      print(e);
    }
  }
}
