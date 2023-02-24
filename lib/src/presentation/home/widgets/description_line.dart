import 'package:flutter/cupertino.dart';

Widget descriptionLine(String text) {
  return Container(
    margin: const EdgeInsets.only(left: 10),
    alignment: Alignment.centerLeft,
    child: Text(
      text,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );
}
