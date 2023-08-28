import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'custom_toast.dart';

Future<bool> onWillPop({
  required BuildContext context,
  required Function(DateTime?) action,
  DateTime? currentBackPressTime,
}) {
  DateTime now = DateTime.now();
  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime) > const Duration(seconds: 3)) {
    action(now);
    customToast(context, AppLocalizations.of(context)!.pressAgainToExit);
    return Future.value(false);
  }
  return Future.value(true);
}
