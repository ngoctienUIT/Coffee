import 'package:flutter/material.dart';

Widget languageWidget({
  required String image,
  required String text,
  required VoidCallback onPress,
  required bool isPick,
}) {
  return InkWell(
    onTap: onPress,
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isPick ? Colors.red : Colors.black54,
          width: isPick ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [Image.asset(image, height: 90), Text(text)],
      ),
    ),
  );
}
