import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/presentation/activity/bloc/activity_event.dart';
import 'package:coffee/src/presentation/activity/bloc/activity_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/api_service.dart';
import '../../../domain/repositories/order/order_response.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  ActivityBloc() : super(InitState()) {
    on<FetchData>((event, emit) => getData(event.index, emit));

    on<UpdateData>((event, emit) => updateData(event.index, emit));
  }

  Future getData(int index, Emitter emit) async {
    try {
      emit(ActivityLoading(index));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String email = prefs.getString("username") ?? "admin";
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));

      List<OrderResponse> listOrder;
      final response = index == 0
          ? await apiService.getAllOrders("Bearer $token", email, "PLACED")
          : await apiService.getAllOrders("Bearer $token", email, "");
      listOrder = index == 0
          ? response.data
          : response.data
              .where((element) =>
                  element.orderStatus == "COMPLETED" ||
                  element.orderStatus == "CANCELLED")
              .toList();
      listOrder.sort((a, b) => b.createdDate!
          .toDateTime2()
          .difference(a.createdDate!.toDateTime2())
          .inSeconds);
      emit(ActivityLoaded(listOrder: listOrder, index: index));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(ActivityError(message: error, index: index));
      print(error);
    } catch (e) {
      emit(ActivityError(message: e.toString(), index: index));
      print(e);
    }
  }

  Future updateData(int index, Emitter emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String email = prefs.getString("username") ?? "admin";
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));

      List<OrderResponse> listOrder;
      final response = index == 0
          ? await apiService.getAllOrders("Bearer $token", email, "PLACED")
          : await apiService.getAllOrders("Bearer $token", email, "");
      listOrder = index == 0
          ? response.data
          : response.data
              .where((element) =>
                  element.orderStatus == "COMPLETED" ||
                  element.orderStatus == "CANCELLED")
              .toList();
      listOrder.sort((a, b) => b.createdDate!
          .toDateTime2()
          .difference(a.createdDate!.toDateTime2())
          .inSeconds);
      emit(UpdateSuccess(listOrder, index));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(ActivityError(message: error, index: index));
      print(error);
    } catch (e) {
      emit(ActivityError(message: e.toString(), index: index));
      print(e);
    }
  }
}
