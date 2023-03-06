import 'package:flutter/material.dart';

Widget orWidget() {
  return Row(
    children: const [
      Expanded(child: Divider(thickness: 1, color: Colors.black54)),
      SizedBox(width: 10),
      Text("Hoặc"),
      SizedBox(width: 10),
      Expanded(child: Divider(thickness: 1, color: Colors.black54)),
    ],
  );
}
