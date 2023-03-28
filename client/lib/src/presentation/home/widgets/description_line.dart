import 'package:flutter/cupertino.dart';

Widget descriptionLine({
  required String text,
  Color? color,
  EdgeInsetsGeometry margin = const EdgeInsets.only(left: 10),
  double fontSize = 20,
}) {
  return Container(
    margin: margin,
    alignment: Alignment.centerLeft,
    child: Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    ),
  );
}
