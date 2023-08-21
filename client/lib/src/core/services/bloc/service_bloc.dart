import 'dart:async';

import 'package:coffee/injection.dart';
import 'package:coffee/src/core/services/bloc/service_event.dart';
import 'package:coffee/src/core/services/bloc/service_state.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart' as inject;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/order.dart';
import '../../../data/remote/api_service/api_service.dart';

@inject.injectable
class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  static Timer? _timer;
  String? timeStr;

  final SharedPreferences _prefs;

  ServiceBloc(this._prefs) : super(InitServiceState()) {
    // on<SetDataEvent>(
    //     (event, emit) => preferencesModel = event.preferencesModel.copyWith());

    on<SaveTimeEvent>((event, emit) => _saveTime(event.duration));

    on<CheckLoginEvent>((event, emit) => _checkLogin(emit));

    on<StopTimeEvent>((event, emit) => _stopTimer());

    on<PlacedOrderEvent>((event, emit) => emit(PlacedOrderState()));

    on<CancelServiceOrderEvent>(
        (event, emit) => emit(CancelServiceOrderState(event.id)));

    on<ChangeUserInfoEvent>((event, emit) => emit(ChangeUserInfoState()));

    on<ChangeOrderEvent>(_changeOrder);

    on<ChangeStoreEvent>(_changeStore);
  }

  Future _changeOrder(ChangeOrderEvent event, Emitter emit) async {
    String? storeID = _prefs.getString("storeID");
    String? address = _prefs.getString("address");
    if ((storeID == null || storeID.isEmpty) &&
        event.order != null &&
        event.order!.selectedPickupOption == "AT_STORE") {
      storeID = event.order!.storeId;
      _prefs.setString("storeID", storeID!);
    }
    if (address == null &&
        event.order != null &&
        event.order!.selectedPickupOption == "DELIVERY") {
      address = event.order!.getAddress();
      _prefs.setString("address", address);
    }
    getIt.resetLazySingleton(instance: Order);
    getIt.registerLazySingleton<Order>(() => event.order!);
    emit(ChangeOrderState());
  }

  Future _changeStore(ChangeStoreEvent event, Emitter emit) async {
    updateStoreOrder();
    emit(ChangeStoreState());
  }

  Future updateStoreOrder() async {
    try {
      String token = _prefs.getString("token") ?? "";
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      Order? order =
          getIt.isRegistered(instance: Order) ? getIt<Order>() : null;
      if (order != null) {
        await apiService.updatePendingOrder(
            "Bearer $token", order.toJson(), order.orderId!);
      }
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      print(error);
    } catch (e) {
      print(e);
    }
  }

  Future _checkLogin(Emitter emit) async {
    String? timeLogin = timeStr;
    if (timeLogin == null) {
      await SharedPreferences.getInstance()
          .then((value) => timeLogin = value.getString('timeLogin') ?? "");
    }
    Duration duration = timeLogin!.toDateTime().difference(DateTime.now());
    if (duration.inSeconds > 0) {
      _startNewTimer(duration, emit);
      await Future.delayed(duration);
    }
  }

  Future _saveTime(Duration duration) async {
    timeStr =
        DateFormat("dd/MM/yyyy HH:mm:ss").format(DateTime.now().add(duration));
    SharedPreferences.getInstance().then((value) {
      value.setString("timeLogin", timeStr!);
      print(timeStr);
    });
  }

  Future _startNewTimer(Duration duration, Emitter emit) async {
    _stopTimer();
    _timer = Timer.periodic(duration, (_) {
      _stopTimer();
      GoogleSignIn().signOut();
      SharedPreferences.getInstance()
          .then((value) => value.setBool("isLogin", false));
      emit(LogOutState());
    });
  }

  void _stopTimer() {
    if (_timer != null || (_timer?.isActive != null && _timer!.isActive)) {
      _timer?.cancel();
    }
  }
}
