import 'dart:async';

import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'service_event.dart';
import 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  static Timer? _timer;
  String? timeStr;

  ServiceBloc() : super(InitServiceState()) {
    // on<SetDataEvent>(
    //     (event, emit) => preferencesModel = event.preferencesModel.copyWith());

    on<SaveTimeEvent>((event, emit) => saveTime(event.duration));

    on<CheckLoginEvent>((event, emit) => checkLogin(emit));

    on<StopTimeEvent>((event, emit) => stopTimer());

    on<ChangeUserInfoEvent>((event, emit) {
      // preferencesModel = preferencesModel.copyWith(user: event.user.copyWith());
      emit(ChangeUserInfoState());
    });
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
