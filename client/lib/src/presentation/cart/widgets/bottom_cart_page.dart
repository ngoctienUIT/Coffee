import 'package:flutter/material.dart';

import '../../login/widgets/custom_button.dart';

Widget bottomCartPage() {
  return Container(
    height: 150,
    color: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: const [
            Text(
              "Tổng cộng",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Spacer(),
            Text(
              "54.000đ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            )
          ],
        ),
        customButton(
          text: "Đặt hàng",
          onPress: () {},
          isOnPress: true,
        ),
      ],
    ),
  );
}
