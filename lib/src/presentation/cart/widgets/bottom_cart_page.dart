import 'package:flutter/material.dart';

import '../../login/widgets/custom_button.dart';

Widget bottomCartPage() {
  return Container(
    height: 150,
    color: Colors.white,
    child: Column(
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.credit_card_rounded),
                  label: const Text("Thẻ nội địa"),
                ),
              ),
              const VerticalDivider(
                color: Colors.black,
                indent: 5,
                endIndent: 5,
              ),
              Expanded(
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.card_membership),
                  label: const Text("Khuyến mãi"),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(10),
          child: customButton(
            text: "Đặt hàng (54.000đ)",
            onPress: () {},
            isOnPress: true,
          ),
        ),
      ],
    ),
  );
}
