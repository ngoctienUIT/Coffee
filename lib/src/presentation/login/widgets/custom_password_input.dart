import 'package:flutter/material.dart';

Widget customPasswordInput({
  required TextEditingController controller,
  required String hint,
  required VoidCallback onPress,
  bool hide = true,
  TextInputType? keyboardType,
}) {
  return TextFormField(
    controller: controller,
    obscureText: hide,
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
      suffixIcon: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: onPress,
        icon: Icon(hide ? Icons.visibility : Icons.visibility_off),
      ),
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
