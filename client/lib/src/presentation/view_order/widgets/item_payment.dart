import 'package:flutter/material.dart';

Widget itemPayment({
  required int value,
  required int groupValue,
  required String image,
  required String title,
}) {
  return Row(
    children: [
      const SizedBox(width: 10),
      Image.asset(image, width: 50),
      const SizedBox(width: 10),
      Text(title),
      const Spacer(),
      Radio(
        value: value,
        groupValue: groupValue,
        onChanged: (int? value) {},
      ),
    ],
  );
}
