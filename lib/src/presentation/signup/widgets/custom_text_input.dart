import 'package:coffee/src/controls/extension/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TypeInput { text, email, phone }

Widget customTextInput({
  required TextEditingController controller,
  required String hint,
  bool checkEdit = true,
  TextInputType? keyboardType,
  List<TextInputFormatter>? inputFormatters,
  TextCapitalization textCapitalization = TextCapitalization.none,
  required List<TypeInput> typeInput,
  String? title,
}) {
  return TextFormField(
    controller: controller,
    enabled: checkEdit,
    keyboardType: keyboardType,
    inputFormatters: inputFormatters,
    textCapitalization: textCapitalization,
    validator: (value) {
      String? error;
      for (TypeInput input in typeInput) {
        switch (input) {
          case TypeInput.text:
            if (value!.isNotEmpty) {
              return null;
            } else {
              error = "Vui lòng nhập vào $title";
            }
            break;
          case TypeInput.email:
            if (value!.isValidEmail()) {
              return null;
            } else if (!value.isValidEmail() && !value.isOnlyNumbers() ||
                value.isEmpty) {
              error = "Vui lòng nhập vào email";
            }
            break;
          case TypeInput.phone:
            if (value!.isValidPhone()) {
              return null;
            } else if (!value.isValidPhone() && value.isOnlyNumbers() ||
                value.isEmpty) {
              error = "Vui lòng nhập vào số điện thoại";
            }
            break;
        }
      }
      return error;
    },
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
