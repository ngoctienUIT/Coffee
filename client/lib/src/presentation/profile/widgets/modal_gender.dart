import 'package:coffee/src/core/utils/extensions/string_extension.dart';
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
              "choose_gender".translate(context),
              () => Navigator.pop(context),
            ),
            const Divider(color: Colors.black),
            GenderWidget(
              gender: "male".translate(context),
              image: AppImages.imgMale,
              onPress: () => onPress(true),
              isPick: isMale,
            ),
            GenderWidget(
              gender: "female".translate(context),
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
