import 'package:coffee/src/presentation/view_order/bloc/view_order_event.dart';
import 'package:coffee/src/presentation/view_order/bloc/view_order_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/api_service.dart';
import '../../../domain/firebase/firebase_service.dart';

class ViewOrderBloc extends Bloc<ViewOrderEvent, ViewOrderState> {
  ViewOrderBloc() : super(InitState()) {
    on<GetOrderEvent>((event, emit) => getData(event.id, emit));

    on<CancelOrderEvent>((event, emit) => cancelOrder(event.id, emit));
  }

  Future getData(String id, Emitter emit) async {
    try {
      emit(ViewOrderLoading());
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.getOrderByID("Bearer $token", id);

      emit(ViewOrderSuccess(response.data));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(ViewOrderError(error));
      print(error);
    } catch (e) {
      emit(ViewOrderError(e.toString()));
      print(e);
    }
  }

  Future cancelOrder(String id, Emitter emit) async {
    try {
      emit(ViewOrderLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      final response = await apiService.cancelOrder("Bearer $token", id);
      sendPushMessageTopic(
        orderID: response.data.orderId!,
        body: "Đơn hàng ${response.data.orderId} đã được hủy thành công",
        title: "Hủy đơn hàng",
      );
      emit(CancelOrderSuccess());
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(ViewOrderError(error));
      print(error);
    } catch (e) {
      emit(ViewOrderError(e.toString()));
      print(e);
    }
  }
}
