import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../utils/constants/constants.dart';

AlertDialog customAlertDialog({
  required BuildContext context,
  required String title,
  required String content,
  required VoidCallback onOK,
}) {
  return AlertDialog(
    title: Center(child: Text(title)),
    content: Text(content),
    actions: [
      IntrinsicHeight(
        child: Row(
          children: [
            const Spacer(),
            TextButton(
              child: Text(
                'cancel'.translate(context),
                style: const TextStyle(
                  color: AppColors.statusBarColor,
                  fontSize: 16,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            const Spacer(),
            const VerticalDivider(
              color: AppColors.statusBarColor,
              thickness: 1,
              endIndent: 5,
              indent: 5,
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                onOK.call();
                Navigator.pop(context);
              },
              child: Text(
                'ok'.translate(context),
                style: const TextStyle(
                  color: AppColors.statusBarColor,
                  fontSize: 16,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      )
    ],
  );
}
