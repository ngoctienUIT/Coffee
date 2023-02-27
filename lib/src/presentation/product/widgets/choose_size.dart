import 'package:flutter/material.dart';

Widget chooseSize(String text, bool check, Function onPress) {
  return SizedBox(
    height: 50,
    width: 90,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor:
            check ? const Color.fromRGBO(177, 40, 48, 1) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () => onPress(),
      child: Text(
        text,
        style: TextStyle(color: check ? Colors.white : Colors.black),
      ),
    ),
  );
}
