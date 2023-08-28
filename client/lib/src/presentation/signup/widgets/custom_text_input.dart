import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/utils/constants/constants.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput({
    Key? key,
    this.radius,
    this.suffixIcon,
    this.textStyle,
    this.isBorder = true,
    required this.hint,
    this.checkEdit = true,
    this.validator,
    this.onPress,
    this.maxLength,
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

  final double? radius;
  final Widget? suffixIcon;
  final TextStyle? textStyle;
  final bool isBorder;
  final String hint;
  final int? maxLength;
  final bool checkEdit;
  final VoidCallback? onPress;
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
  final String? Function(String? value)? validator;

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
      validator: validator,
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
                borderSide: BorderSide(
                    color: onPress != null
                        ? colorBorder
                        : AppColors.statusBarColor,
                    width: 1),
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
    );
  }
}
