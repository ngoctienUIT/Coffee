import 'package:coffee/src/data/models/address.dart';
import 'package:dvhcvn/dvhcvn.dart' as dvhcvn;
import 'package:flutter/material.dart';

import '../../services/language/localization/app_localizations.dart';

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

  bool isSpecialCharacters() {
    return RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(this);
  }

  TimeOfDay toTime() {
    final list = split(":");
    return TimeOfDay(hour: int.parse(list[0]), minute: int.parse(list[1]));
  }

  Duration toDuration() {
    final list = split(":");
    return Duration(
        hours: int.parse(list[0]),
        minutes: int.parse(list[1]),
        seconds: int.parse(list[2]));
  }

  DateTime toDate() {
    final list = split("/");
    return DateTime(int.parse(list[2]), int.parse(list[1]), int.parse(list[0]));
  }

  DateTime toDateTime() {
    String firstStr = split(" ").first;
    String lastStr = split(" ").last;
    return firstStr.toDate().add(lastStr.toDuration());
  }

  DateTime toDate2() {
    final list = split("-");
    return DateTime(int.parse(list[2]), int.parse(list[1]), int.parse(list[0]));
  }

  DateTime toDateTime2() {
    String firstStr = split(" ").first;
    String lastStr = split(" ").last;
    return firstStr.toDate2().add(lastStr.toDuration());
  }

  String translate(BuildContext context) {
    return AppLocalizations.of(context).translate(this);
  }

  AddressAPI toAddressAPI() {
    List<String> list = split(", ");
    dvhcvn.Level1? province = dvhcvn.findLevel1ByName(list[3]);
    dvhcvn.Level2? district = province!.findLevel2ByName(list[2]);
    dvhcvn.Level3? ward = district!.findLevel3ByName(list[1]);
    return AddressAPI(
        province: province, district: district, ward: ward, address: list[0]);
  }

  List<String> toListAddress() {
    return split(", ");
  }
}
