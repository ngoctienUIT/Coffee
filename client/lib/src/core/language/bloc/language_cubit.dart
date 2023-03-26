import 'dart:io' show Platform;

import 'package:flutter/material.dart' show Locale;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  int? language;

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
}
