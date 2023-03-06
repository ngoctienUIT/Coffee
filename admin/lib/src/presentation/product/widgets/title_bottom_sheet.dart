import 'package:flutter/material.dart';

Widget titleBottomSheet(String title, VoidCallback onPress) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Positioned(
          left: 0,
          child: TextButton(
            onPressed: onPress,
            child: const Icon(Icons.close, size: 35),
          ),
        ),
      ],
    ),
  );
}
