import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/utils/constants/constants.dart';
import '../../../core/utils/enum/enums.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput({
    Key? key,
    this.title,
    this.radius,
    this.suffixIcon,
    this.textStyle,
    this.isBorder = true,
    required this.hint,
    this.checkEdit = true,
    this.onPress,
    this.maxLength,
    this.typeInput,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.controller,
    this.backgroundColor = Colors.white,
    this.inputFormatters,
    this.colorBorder = AppColors.borderColor,
    this.onFieldSubmitted,
    this.textCapitalization = TextCapitalization.none,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 10),
  }) : super(key: key);

  final String? title;
  final double? radius;
  final Widget? suffixIcon;
  final TextStyle? textStyle;
  final bool isBorder;
  final String hint;
  final int? maxLength;
  final bool checkEdit;
  final VoidCallback? onPress;
  final List<TypeInput>? typeInput;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final Color backgroundColor;
  final List<TextInputFormatter>? inputFormatters;
  final Color colorBorder;
  final TextCapitalization textCapitalization;
  final EdgeInsetsGeometry contentPadding;
  final Function(String value)? onFieldSubmitted;
  final Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onPress,
      style: textStyle,
      enabled: checkEdit,
      onChanged: onChanged,
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization,
      readOnly: onPress == null ? false : true,
      onFieldSubmitted: onFieldSubmitted,
      maxLength: maxLength,
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
                borderSide:
                    const BorderSide(color: AppColors.statusBarColor, width: 1),
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
          return showError(context, value, title, typeInput!);
        }
        return null;
      },
    );
  }

  String? showError(
    BuildContext context,
    String? value,
    String? title,
    List<TypeInput> typeInput,
  ) {
    String? error;
    for (TypeInput input in typeInput) {
      switch (input) {
        case TypeInput.text:
          if (value!.isNotEmpty) {
            return null;
          } else {
            error = "${"please_enter".translate(context)} $title";
          }
          break;
        case TypeInput.email:
          if (value!.isValidEmail()) {
            return null;
          } else if (!value.isValidEmail() && !value.isOnlyNumbers() ||
              value.isEmpty) {
            error = "please_enter_email".translate(context);
          }
          break;
        case TypeInput.phone:
          if (value!.isValidPhone()) {
            return null;
          } else if (!value.isValidPhone() && value.isOnlyNumbers() ||
              value.isEmpty) {
            error = "please_enter_phone_number".translate(context);
          }
          break;
      }
    }
    return error;
  }
}
