import 'package:flutter/material.dart';

import '../../language/localization/app_localizations.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r"^[a-zA-Z\d.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z\d](?:[a-zA-Z\d-]{0,253}[a-zA-Z\d])?(?:\.[a-zA-Z\d](?:[a-zA-Z\d-]{0,253}[a-zA-Z\d])?)*$")
        .hasMatch(this);
  }

  bool isValidPhone() {
    return RegExp(r"^(?:[+0]9)?\d{10}$").hasMatch(this);
  }

  bool isOnlyNumbers() {
    return RegExp(r"\d+$").hasMatch(this);
  }

  String translate(BuildContext context) {
    return AppLocalizations.of(context).translate(this);
  }

  bool isSpecialCharacters() {
    return RegExp(r"[^\w\s]").hasMatch(this);
  }

  TimeOfDay toTime() {
    final list = split(":");
    return TimeOfDay(hour: int.parse(list[0]), minute: int.parse(list[1]));
  }

  DateTime toDateTime() {
    final list = split("/");
    return DateTime(int.parse(list[2]), int.parse(list[1]), int.parse(list[0]));
  }
}
