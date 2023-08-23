import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/constants/constants.dart';
import '../../order/widgets/title_bottom_sheet.dart';
import 'gender_widget.dart';

void showMyBottomSheet({
  required BuildContext context,
  required Function(bool isMale) onPress,
  required bool isMale,
}) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    context: context,
    builder: (context) {
      return Container(
        height: 250,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            titleBottomSheet(
              AppLocalizations.of(context).chooseGender,
              () => Navigator.pop(context),
            ),
            const Divider(color: Colors.black),
            GenderWidget(
              gender: AppLocalizations.of(context).male,
              image: AppImages.imgMale,
              onPress: () => onPress(true),
              isPick: isMale,
            ),
            GenderWidget(
              gender: AppLocalizations.of(context).female,
              image: AppImages.imgFemale,
              onPress: () => onPress(false),
              isPick: !isMale,
            ),
          ],
        ),
      );
    },
  );
}
