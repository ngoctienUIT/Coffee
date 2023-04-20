import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:coffee_admin/src/presentation/order/bloc/order_event.dart';
import 'package:coffee_admin/src/presentation/order/bloc/order_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/api_service.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(InitState()) {
    on<FetchData>((event, emit) => getData(emit));

    on<RefreshData>((event, emit) => getDataOrder(event.index, emit));

    on<UpdateData>((event, emit) => getDataOrder(event.index, emit));
  }

  Future getData(Emitter emit) async {
    try {
      emit(OrderLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      final response = await apiService.getAllOrders('Bearer $token', "", "");
      final listOrder = response.data
          .where((element) => element.orderStatus != "PENDING")
          .toList();
      listOrder.sort((a, b) => b.createdDate!
          .toDateTime2()
          .difference(a.createdDate!.toDateTime2())
          .inSeconds);

      emit(OrderLoaded(0, listOrder));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(OrderError(error));
      print(error);
    } catch (e) {
      emit(OrderError(e.toString()));
      print(e);
    }
  }

  Future getDataOrder(int index, Emitter emit) async {
    try {
      emit(OrderLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String status = index == 0
          ? ""
          : (index == 1 ? "PLACED" : (index == 2 ? "COMPLETED" : "CANCELLED"));
      final response =
          await apiService.getAllOrders('Bearer $token', "", status);
      final listOrder = index != 0
          ? response.data
          : response.data
              .where((element) => element.orderStatus != "PENDING")
              .toList();
      listOrder.sort((a, b) => b.createdDate!
          .toDateTime2()
          .difference(a.createdDate!.toDateTime2())
          .inSeconds);

      emit(OrderLoaded(index, listOrder));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(OrderError(error));
      print(error);
    } catch (e) {
      emit(OrderError(e.toString()));
      print(e);
    }
  }

  Future updateDataOrder(int index, Emitter emit) async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String status = index == 0
          ? ""
          : (index == 1 ? "PLACED" : (index == 2 ? "COMPLETED" : "CANCELLED"));
      final response =
          await apiService.getAllOrders('Bearer $token', "", status);
      final listOrder = index != 0
          ? response.data
          : response.data
              .where((element) => element.orderStatus != "PENDING")
              .toList();
      listOrder.sort((a, b) => b.createdDate!
          .toDateTime2()
          .difference(a.createdDate!.toDateTime2())
          .inSeconds);

      emit(OrderLoaded(index, listOrder));
    } on DioError catch (e) {
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
