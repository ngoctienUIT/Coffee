import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
          return AppLocalizations.of(context)!.confirmationPasswordNotMatch;
        }
        if (!value!.isSpecialCharacters()) {
          return AppLocalizations.of(context)!.requiresSpecialCharacters;
        }
        if (value.isEmpty) {
          return AppLocalizations.of(context)!.pleaseEnterPassword;
        }
        if (value.length < 8) {
          return AppLocalizations.of(context)!.passwordLengthLeastCharacters;
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
          borderSide: BorderSide(color: AppColors.statusBarColor, width: 1),
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
