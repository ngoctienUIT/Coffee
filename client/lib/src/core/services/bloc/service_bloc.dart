import 'dart:async';

import 'package:coffee/src/core/services/bloc/service_event.dart';
import 'package:coffee/src/core/services/bloc/service_state.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/order.dart';
import '../../../data/models/preferences_model.dart';
import '../../../domain/api_service.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  PreferencesModel preferencesModel = PreferencesModel();
  static Timer? _timer;
  String? timeStr;

  ServiceBloc() : super(InitServiceState()) {
    on<SetDataEvent>(
        (event, emit) => preferencesModel = event.preferencesModel.copyWith());

    on<SaveTimeEvent>((event, emit) => saveTime(event.duration));

    on<CheckLoginEvent>((event, emit) => checkLogin(emit));

    on<StopTimeEvent>((event, emit) => stopTimer());

    on<PlacedOrderEvent>((event, emit) => emit(PlacedOrderState()));

    on<ChangeUserInfoEvent>((event, emit) {
      preferencesModel = preferencesModel.copyWith(user: event.user.copyWith());
      emit(ChangeUserInfoState());
    });

    on<ChangeOrderEvent>((event, emit) {
      if ((preferencesModel.storeID == null ||
              preferencesModel.storeID!.isEmpty) &&
          event.order != null &&
          event.order!.selectedPickupOption == "AT_STORE") {
        print("change store in change order event");
        preferencesModel.storeID = event.order!.storeId;
        SharedPreferences.getInstance().then(
            (value) => value.setString("storeID", preferencesModel.storeID!));
      }
      if (preferencesModel.address == null &&
          event.order != null &&
          event.order!.selectedPickupOption == "DELIVERY") {
        print("change address in change order event");
        preferencesModel.address = event.order!.getAddress();
        SharedPreferences.getInstance().then(
            (value) => value.setString("address", preferencesModel.address!));
      }
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

  Future checkLogin(Emitter emit) async {
    String? timeLogin = timeStr;
    if (timeLogin == null) {
      await SharedPreferences.getInstance()
          .then((value) => timeLogin = value.getString('timeLogin') ?? "");
    }
    Duration duration = timeLogin!.toDateTime().difference(DateTime.now());
    if (duration.inSeconds > 0) {
      startNewTimer(duration, emit);
      await Future.delayed(duration);
    }
  }

  Future saveTime(Duration duration) async {
    timeStr =
        DateFormat("dd/MM/yyyy HH:mm:ss").format(DateTime.now().add(duration));
    SharedPreferences.getInstance().then((value) {
      value.setString("timeLogin", timeStr!);
      print(timeStr);
    });
  }

  Future startNewTimer(Duration duration, Emitter emit) async {
    stopTimer();
    _timer = Timer.periodic(duration, (_) {
      stopTimer();
      GoogleSignIn().signOut();
      SharedPreferences.getInstance()
          .then((value) => value.setBool("isLogin", false));
      emit(LogOutState());
    });
  }

  void stopTimer() {
    if (_timer != null || (_timer?.isActive != null && _timer!.isActive)) {
      _timer?.cancel();
    }
  }
}
