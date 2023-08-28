import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
                AppLocalizations.of(context)!.cancel,
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
                AppLocalizations.of(context)!.ok,
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
