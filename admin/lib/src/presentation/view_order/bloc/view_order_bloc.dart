import 'package:coffee_admin/src/presentation/view_order/bloc/view_order_event.dart';
import 'package:coffee_admin/src/presentation/view_order/bloc/view_order_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/api_service.dart';
import '../../../domain/firebase/firebase_service.dart';

class ViewOrderBloc extends Bloc<ViewOrderEvent, ViewOrderState> {
  ViewOrderBloc() : super(InitState()) {
    on<CancelOrderEvent>(
        (event, emit) => cancelOrder(event.id, event.userID, emit));

    on<OrderCompletedEvent>(
        (event, emit) => orderCompleted(event.id, event.userID, emit));
  }

  Future cancelOrder(String id, String userID, Emitter emit) async {
    try {
      emit(LoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      await apiService.cancelOrder("Bearer $token", id);
      emit(CancelSuccessState());
      sendPushMessage(
        token: await getTokenFCM(userID),
        orderID: id,
        body: "Đơn hàng $id đã được hủy thành công",
        title: "Đơn hàng bị hủy",
      );
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      ErrorState(error);
      print(error);
    } catch (e) {
      ErrorState(e.toString());
      print(e);
    }
  }

  Future orderCompleted(String id, String userID, Emitter emit) async {
    try {
      emit(LoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      await apiService.closeSuccessOrder("Bearer $token", id);
      emit(CompletedSuccessState());
      sendPushMessage(
        token: await getTokenFCM(userID),
        orderID: id,
        body: "Đơn hàng $id đã được xác nhận thành công",
        title: "Đơn hàng đã xác nhận",
      );
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      ErrorState(error);
      print(error);
    } catch (e) {
      ErrorState(e.toString());
      print(e);
    }
  }
}