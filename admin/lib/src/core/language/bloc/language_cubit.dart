import 'dart:async';
import 'dart:io' show Platform;

import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../presentation/login/screen/login_page.dart';
import '../../function/custom_toast.dart';
import '../../function/route_function.dart';
import 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  int? language;
  static Timer? _timer;

  LanguageCubit({this.language}) : super(LanguageChange(_getLocal(language)));

  static Locale _getLocal(int? lang) {
    return lang == null
        ? Locale(Platform.localeName.split('_')[0] == "vi" ? "vi" : "en")
        : (lang == 0 ? const Locale('vi') : const Locale('en'));
  }

  void toVietnamese() {
    language = 0;
    emit(const LanguageChange(Locale('vi')));
  }

  void toEnglish() {
    language = 1;
    emit(const LanguageChange(Locale('en')));
  }

  void checkLogin(BuildContext context) {
    SharedPreferences.getInstance().then((value) {
      String? timeLogin = value.getString('timeLogin');
      Duration duration = DateTime.now().difference(timeLogin!.toDateTime());
      print(DateFormat("dd/MM/yyyy HH:mm:ss").format(timeLogin.toDateTime()));
      if (duration.inSeconds > 0) startNewTimer(context, duration);
    });
  }

  Future startNewTimer(BuildContext context, Duration duration) async {
    stopTimer();
    SharedPreferences.getInstance().then((value) {
      value.setString(
          "timeLogin",
          DateFormat("dd/MM/yyyy HH:mm:ss")
              .format(DateTime.now().add(duration)));
    });
    _timer = Timer.periodic(duration, (_) {
      _timedOut();
      customToast(
          context, "login_expired_please_login_again".translate(context));
      Navigator.of(context).pushAndRemoveUntil(
        createRoute(
          screen: const LoginPage(),
          begin: const Offset(0, 1),
        ),
        (route) => false,
      );
    });
  }

  void stopTimer() {
    if (_timer != null || (_timer?.isActive != null && _timer!.isActive)) {
      _timer?.cancel();
    }
  }

  Future<void> _timedOut() async {
    stopTimer();
    SharedPreferences.getInstance().then((value) {
      value.setBool("isLogin", false);
      value.setString("storeID", "");
      value.setBool("isBringBack", false);
    });
  }
}
