import 'package:flutter/material.dart';

Widget itemPayment({
  required Function(int? value) onChange,
  required Function onPress,
  required int value,
  required int groupValue,
  required String image,
  required String title,
}) {
  return InkWell(
    onTap: () => onPress(),
    child: Row(
      children: [
        const SizedBox(width: 10),
        Image.asset(image, width: 50),
        const SizedBox(width: 10),
        Text(title),
        const Spacer(),
        Radio(
          value: value,
          groupValue: groupValue,
          onChanged: (value) => onChange(value),
        ),
      ],
    ),
  );
}
