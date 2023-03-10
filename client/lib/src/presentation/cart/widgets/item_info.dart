import 'package:flutter/material.dart';

Widget itemInfo(IconData icon, String content) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      children: [
        Icon(icon),
        const SizedBox(width: 5),
        Text(content),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios_rounded)
      ],
    ),
  );
}
