import 'package:flutter/material.dart';

import '../../../core/utils/constants/constants.dart';
import '../../home/widgets/description_line.dart';

Widget groupItemOther(String description, List<Widget> list) {
  return Column(
    children: [
      const SizedBox(height: 20),
      descriptionLine(text: description, color: AppColors.textColor),
      const SizedBox(height: 10),
      Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(children: list),
        ),
      ),
    ],
  );
}
