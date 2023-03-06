import 'package:coffee/src/controls/extension/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TypeInput { text, email, phone }

Widget customTextInput({
  TextEditingController? controller,
  required String hint,
  bool checkEdit = true,
  TextInputType? keyboardType,
  List<TextInputFormatter>? inputFormatters,
  TextCapitalization textCapitalization = TextCapitalization.none,
  List<TypeInput>? typeInput,
  String? title,
  double? radius,
  EdgeInsetsGeometry contentPadding =
      const EdgeInsets.symmetric(horizontal: 10),
  Widget? suffixIcon,
  TextInputAction? textInputAction,
  TextStyle? textStyle,
  VoidCallback? onPress,
  Color backgroundColor = Colors.white,
}) {
  return TextFormField(
    onTap: onPress,
    readOnly: onPress == null ? false : true,
    controller: controller,
    enabled: checkEdit,
    keyboardType: keyboardType,
    inputFormatters: inputFormatters,
    textCapitalization: textCapitalization,
    validator: (value) {
      if (typeInput != null) {
        return showError(value, title, typeInput);
      }
      return null;
    },
    style: textStyle,
    textInputAction: textInputAction,
    decoration: InputDecoration(
      contentPadding: contentPadding,
      hintText: hint,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
        borderSide: const BorderSide(
          color: Color.fromRGBO(220, 220, 220, 1),
          width: 0.7,
        ),
      ),
      filled: true,
      fillColor: backgroundColor,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
        borderSide: const BorderSide(
          color: Color.fromRGBO(220, 220, 220, 1),
          width: 0.7,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
        borderSide: const BorderSide(
          color: Color.fromRGBO(220, 220, 220, 1),
          width: 0.7,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
        borderSide: const BorderSide(
          color: Color.fromRGBO(220, 220, 220, 1),
          width: 0.7,
        ),
      ),
    ),
  );
}

String? showError(String? value, String? title, List<TypeInput> typeInput) {
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
}
