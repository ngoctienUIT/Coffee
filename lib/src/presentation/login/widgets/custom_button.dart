import 'package:flutter/material.dart';

Widget customButton(String text, VoidCallback onPress) {
  return SizedBox(
    width: double.infinity,
    height: 50,
    child: ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(90),
        ),
        backgroundColor: const Color.fromRGBO(177, 40, 48, 1),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18),
      ),
    ),
  );
}
