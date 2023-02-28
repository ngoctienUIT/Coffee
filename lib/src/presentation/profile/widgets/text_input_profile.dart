import 'package:flutter/material.dart';

Widget textInputProfile({
  required TextEditingController controller,
  required String hint,
  required bool checkEdit,
  TextInputType? keyboardType,
}) {
  return TextFormField(
    controller: controller,
    enabled: checkEdit,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      hintText: hint,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
        borderSide: BorderSide(
          color: Color.fromRGBO(220, 220, 220, 1),
          width: 0.7,
        ),
      ),
      filled: true,
      fillColor: Colors.white,
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
        borderSide: BorderSide(
          color: Color.fromRGBO(220, 220, 220, 1),
          width: 0.7,
        ),
      ),
      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
        borderSide: BorderSide(
          color: Color.fromRGBO(220, 220, 220, 1),
          width: 0.7,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
        borderSide: BorderSide(
          color: Color.fromRGBO(220, 220, 220, 1),
          width: 0.7,
        ),
      ),
    ),
  );
}
