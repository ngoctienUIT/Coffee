import 'package:flutter/material.dart';

import '../../../core/utils/constants/constants.dart';

Widget customButtonQuantity(VoidCallback onPress, IconData icon) {
  return SizedBox(
    height: 35,
    width: 35,
    child: OutlinedButton(
      onPressed: onPress,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.zero,
        foregroundColor: Colors.white,
        backgroundColor: AppColors.statusBarColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      child: Icon(icon),
    ),
  );
}
