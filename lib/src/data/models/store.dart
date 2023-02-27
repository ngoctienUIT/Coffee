import 'package:coffee/src/controls/extension/time_of_date_extension.dart';
import 'package:flutter/material.dart';

class Store {
  String image;
  String name;
  String address;
  String phone;
  TimeOfDay startDay;
  TimeOfDay endDay;

  Store({
    required this.image,
    required this.name,
    required this.address,
    required this.phone,
    required this.startDay,
    required this.endDay,
  });

  bool checkOpen() {
    int start = startDay.hour * 60 + startDay.minute;
    int current = DateTime.now().hour * 60 + DateTime.now().minute;
    int end = endDay.hour * 60 + endDay.minute;
    if (start < current && current < end) return true;
    return false;
  }

  String rangeTime() {
    return "${startDay.toTimeString()} - ${endDay.toTimeString()}";
  }
}
