import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/constants/constants.dart';

class CustomPasswordInput extends StatelessWidget {
  const CustomPasswordInput({
    Key? key,
    required this.controller,
    required this.hint,
    required this.onPress,
    this.hide = true,
    this.keyboardType,
    this.confirmPassword,
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;
  final VoidCallback onPress;
  final bool hide;
  final TextInputType? keyboardType;
  final String? confirmPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: hide,
      keyboardType: keyboardType,
      validator: (value) {
        if (confirmPassword != null && confirmPassword != value) {
          return "confirmation_password_not_match".translate(context);
        }
        if (!value!.isSpecialCharacters()) {
          return "Cần phải có ký tự đặc biệt";
        }
        if (value.isEmpty) {
          return "please_enter_password".translate(context);
        }
        if (value.length < 8) {
          return "password_length_least_characters".translate(context);
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        hintText: hint,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
          borderSide: BorderSide(color: AppColors.borderColor, width: 0.7),
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
          borderSide: BorderSide(color: AppColors.borderColor, width: 0.7),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
          borderSide: BorderSide(color: AppColors.borderColor, width: 0.7),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
          borderSide: BorderSide(color: AppColors.borderColor, width: 0.7),
        ),
      ),
    );
  }
}
