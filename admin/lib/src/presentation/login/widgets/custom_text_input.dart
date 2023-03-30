import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/utils/constants/constants.dart';
import '../../../core/utils/enum/enums.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput({
    Key? key,
    this.controller,
    required this.hint,
    this.checkEdit = true,
    this.keyboardType,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.typeInput = const [TypeInput.text],
    this.title,
    this.radius,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 10),
    this.suffixIcon,
    this.textInputAction,
    this.textStyle,
    this.onPress,
    this.backgroundColor = Colors.white,
    this.maxLines,
    this.onChanged,
  }) : super(key: key);

  final TextEditingController? controller;
  final String hint;
  final bool checkEdit;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final List<TypeInput> typeInput;
  final String? title;
  final double? radius;
  final EdgeInsetsGeometry contentPadding;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final TextStyle? textStyle;
  final VoidCallback? onPress;
  final Color backgroundColor;
  final int? maxLines;
  final Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onPress,
      style: textStyle,
      enabled: checkEdit,
      maxLines: maxLines,
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization,
      readOnly: onPress == null ? false : true,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        hintText: hint,
        suffixIcon: suffixIcon,
        fillColor: backgroundColor,
        contentPadding: contentPadding,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
          borderSide:
              const BorderSide(color: AppColors.borderColor, width: 0.7),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
          borderSide:
              const BorderSide(color: AppColors.borderColor, width: 0.7),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
          borderSide:
              const BorderSide(color: AppColors.borderColor, width: 0.7),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
          borderSide:
              const BorderSide(color: AppColors.borderColor, width: 0.7),
        ),
      ),
      validator: (value) {
        return showError(value, title, typeInput);
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
}
