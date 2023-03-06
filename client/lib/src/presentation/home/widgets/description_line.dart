import 'package:flutter/cupertino.dart';

Widget descriptionLine({required String text, Color? color}) {
  return Container(
    margin: const EdgeInsets.only(left: 10),
    alignment: Alignment.centerLeft,
    child: Text(
      text,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
    ),
  );
}
