import 'package:flutter/material.dart';

extension ToString on TimeOfDay {
  String toTimeString() {
    return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
  }

  int toInt() => hour * 60 + minute;
}
