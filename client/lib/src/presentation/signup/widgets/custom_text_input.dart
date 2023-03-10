import 'package:coffee/src/controls/extension/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TypeInput { text, email, phone }

Widget customTextInput({
  String? title,
  double? radius,
  Widget? suffixIcon,
  TextStyle? textStyle,
  bool isBorder = true,
  required String hint,
  bool checkEdit = true,
  VoidCallback? onPress,
  List<TypeInput>? typeInput,
  TextInputType? keyboardType,
  TextInputAction? textInputAction,
  TextEditingController? controller,
  Color backgroundColor = Colors.white,
  List<TextInputFormatter>? inputFormatters,
  Color colorBorder = const Color.fromRGBO(220, 220, 220, 1),
  TextCapitalization textCapitalization = TextCapitalization.none,
  EdgeInsetsGeometry contentPadding =
      const EdgeInsets.symmetric(horizontal: 10),
}) {
  return TextFormField(
    onTap: onPress,
    style: textStyle,
    enabled: checkEdit,
    controller: controller,
    keyboardType: keyboardType,
    textInputAction: textInputAction,
    inputFormatters: inputFormatters,
    textCapitalization: textCapitalization,
    readOnly: onPress == null ? false : true,
    decoration: InputDecoration(
      filled: true,
      hintText: hint,
      suffixIcon: suffixIcon,
      fillColor: backgroundColor,
      contentPadding: contentPadding,
      border: !isBorder
          ? InputBorder.none
          : OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
              borderSide: BorderSide(color: colorBorder, width: 0.7),
            ),
      focusedBorder: !isBorder
          ? InputBorder.none
          : OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
              borderSide: BorderSide(color: colorBorder, width: 0.7),
            ),
      disabledBorder: !isBorder
          ? InputBorder.none
          : OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
              borderSide: BorderSide(color: colorBorder, width: 0.7),
            ),
      enabledBorder: !isBorder
          ? InputBorder.none
          : OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
              borderSide: BorderSide(color: colorBorder, width: 0.7),
            ),
    ),
    validator: (value) {
      if (typeInput != null) {
        return showError(value, title, typeInput);
      }
      return null;
    },
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
