import 'package:coffee/src/presentation/view_order/bloc/view_order_event.dart';
import 'package:coffee/src/presentation/view_order/bloc/view_order_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/preferences_model.dart';
import '../../../domain/firebase/firebase_service.dart';

class ViewOrderBloc extends Bloc<ViewOrderEvent, ViewOrderState> {
  PreferencesModel preferencesModel;

  ViewOrderBloc(this.preferencesModel) : super(InitState()) {
    on<GetOrderEvent>((event, emit) => getData(event.id, emit));

    on<CancelOrderEvent>((event, emit) => cancelOrder(event.id, emit));
  }

  Future getData(String id, Emitter emit) async {
    try {
      emit(ViewOrderLoading());
      final response = await preferencesModel.apiService
          .getOrderByID("Bearer ${preferencesModel.token}", id);

      emit(ViewOrderSuccess(response.data));
    } on DioException catch (e) {
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
      final response = await preferencesModel.apiService
          .cancelOrder("Bearer ${preferencesModel.token}", id);
      emit(CancelOrderSuccess(id));
      sendPushMessageTopic(
        orderID: response.data.orderId!,
        body: "Đơn hàng ${response.data.orderId} đã được hủy thành công",
        title: "Hủy đơn hàng",
      );
    } on DioException catch (e) {
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
