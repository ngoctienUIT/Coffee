import 'package:coffee/src/core/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

Widget customButton({
  required String text,
  required VoidCallback onPress,
  bool isOnPress = false,
  double fontSize = 18,
}) {
  return SizedBox(
    width: double.infinity,
    height: 50,
    child: ElevatedButton(
      onPressed: isOnPress ? onPress : null,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(90),
        ),
        disabledBackgroundColor: const Color.fromRGBO(221, 221, 221, 1),
        backgroundColor: AppColors.statusBarColor,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: isOnPress ? null : AppColors.unselectedColor,
        ),
      ),
    ),
  );
}
