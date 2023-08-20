import 'package:coffee_admin/src/presentation/view_order/bloc/view_order_event.dart';
import 'package:coffee_admin/src/presentation/view_order/bloc/view_order_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/preferences_model.dart';
import '../../../data/models/user.dart';
import '../../../data/remote/firebase/firebase_service.dart';

class ViewOrderBloc extends Bloc<ViewOrderEvent, ViewOrderState> {
  PreferencesModel preferencesModel;

  ViewOrderBloc(this.preferencesModel) : super(InitState()) {
    on<CancelOrderEvent>(
        (event, emit) => cancelOrder(event.id, event.userID, emit));

    on<OrderCompletedEvent>(
        (event, emit) => orderCompleted(event.id, event.userID, emit));

    on<GetOrderEvent>((event, emit) => getOrder(event.id, emit));
  }

  Future cancelOrder(String id, String userID, Emitter emit) async {
    try {
      emit(LoadingState());
      await preferencesModel.apiService
          .cancelOrder("Bearer ${preferencesModel.token}", id);
      emit(CancelSuccessState());
      sendPushMessage(
        token: await getTokenFCM(userID),
        orderID: id,
        body: "Đơn hàng $id đã được hủy thành công",
        title: "Đơn hàng bị hủy",
      );
    } on DioException catch (e) {
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
      await preferencesModel.apiService
          .closeSuccessOrder("Bearer ${preferencesModel.token}", id);
      emit(CompletedSuccessState());
      sendPushMessage(
        token: await getTokenFCM(userID),
        orderID: id,
        body: "Đơn hàng $id đã được xác nhận thành công",
        title: "Đơn hàng đã xác nhận",
      );
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      ErrorState(error);
      print(error);
    } catch (e) {
      ErrorState(e.toString());
      print(e);
    }
  }

  Future getOrder(String id, Emitter emit) async {
    try {
      emit(LoadingState());
      final orderResponse = await preferencesModel.apiService
          .getOrderByID("Bearer ${preferencesModel.token}", id);
      final userResponse = await preferencesModel.apiService.getUserByID(
          "Bearer ${preferencesModel.token}", orderResponse.data.userId!);
      emit(GetOrderSuccessState(
          User.fromUserResponse(userResponse.data), orderResponse.data));
    } on DioException catch (e) {
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
