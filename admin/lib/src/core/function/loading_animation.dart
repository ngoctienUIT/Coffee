import 'package:coffee_admin/src/core/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

void loadingAnimation(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.statusBarColor),
      );
    },
  );
}
