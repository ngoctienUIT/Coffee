import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/constants/constants.dart';

class CustomPickerWidget extends StatelessWidget {
  const CustomPickerWidget({
    Key? key,
    required this.checkEdit,
    required this.text,
    this.onPress,
  }) : super(key: key);
  final bool checkEdit;
  final String text;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: checkEdit ? onPress : null,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderColor, width: 0.7),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Row(
          children: [
            Text(text, style: const TextStyle(fontSize: 16)),
            const Spacer(),
            if (checkEdit)
              Text(
                AppLocalizations.of(context).select,
                style: const TextStyle(color: Colors.blue),
              ),
          ],
        ),
      ),
    );
  }
}
