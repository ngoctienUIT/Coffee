import 'package:flutter/material.dart';

import '../../../core/utils/constants/constants.dart';

Widget itemOther(String text, IconData icon, Function onPress) {
  return InkWell(
    onTap: () => onPress(),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: const Color.fromRGBO(180, 40, 50, 1)),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(fontSize: 16, color: AppColors.textColor),
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Color.fromRGBO(51, 51, 51, 1),
          )
        ],
      ),
    ),
  );
}
