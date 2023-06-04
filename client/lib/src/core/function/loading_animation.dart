import 'package:coffee/src/core/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

void loadingAnimation(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: const Center(
          child: CircularProgressIndicator(color: AppColors.statusBarColor),
        ),
      );
    },
  );
}
