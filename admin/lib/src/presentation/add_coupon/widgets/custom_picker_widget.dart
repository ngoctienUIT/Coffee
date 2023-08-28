import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/constants/constants.dart';

class CustomPickerWidget extends StatelessWidget {
  const CustomPickerWidget({
    Key? key,
    required this.text,
    required this.onPress,
  }) : super(key: key);

  final String text;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderColor, width: 0.7),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Row(
          children: [
            Text(
              text,
              style:
                  TextStyle(fontSize: 16, color: Theme.of(context).hintColor),
            ),
            const Spacer(),
            Text(
              AppLocalizations.of(context)!.select,
              style: const TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
