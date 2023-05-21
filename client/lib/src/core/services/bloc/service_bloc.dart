import 'package:coffee/src/core/services/bloc/service_event.dart';
import 'package:coffee/src/core/services/bloc/service_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/order.dart';
import '../../../data/models/preferences_model.dart';
import '../../../domain/api_service.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  PreferencesModel preferencesModel = PreferencesModel();

  ServiceBloc() : super(InitServiceState()) {
    on<SetDataEvent>(
        (event, emit) => preferencesModel = event.preferencesModel.copyWith());

    on<ChangeUserInfoEvent>((event, emit) {
      preferencesModel = preferencesModel.copyWith(user: event.user.copyWith());
      emit(ChangeUserInfoState());
    });

    on<ChangeOrderEvent>((event, emit) {
      preferencesModel = preferencesModel.copyWith(
        order: event.order != null ? event.order!.copyWith() : null,
        isChangeOrder: true,
      );
      emit(ChangeOrderState());
    });

    on<ChangeStoreEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      String? storeID = prefs.getString("storeID");
      String? address = prefs.getString("address");
      bool isBringBack = prefs.getBool("isBringBack") ?? false;
      preferencesModel = preferencesModel.copyWith(
        storeID: isBringBack ? null : storeID,
        address: isBringBack ? address : null,
        isBringBack: isBringBack,
      );
      print("update order");
      print(preferencesModel.order);
      updateStoreOrder();
      emit(ChangeStoreState());
    });
  }

  Future updateStoreOrder() async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      Order? order = preferencesModel.order != null
          ? preferencesModel.order!.copyWith()
          : null;
      // String storeID = preferencesModel.storeID ?? "";
      if (order != null) {
        // if (order.selectedPickupOption == "AT_STORE") {
        //   if (storeID.isEmpty) {
        //     storeID = "6425d2c7cf1d264dca4bcc82";
        //     SharedPreferences.getInstance().then((value) {
        //       value.setString("storeID", "6425d2c7cf1d264dca4bcc82");
        //     });
        //   }
        //   order.storeId = storeID;
        // }
        await apiService.updatePendingOrder(
            "Bearer ${preferencesModel.token}", order.toJson(), order.orderId!);
      }
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      print(error);
    } catch (e) {
      print(e);
    }
  }
}
