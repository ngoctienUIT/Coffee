import 'package:flutter/material.dart';

Widget genderWidget(String gender, String image, VoidCallback onPress) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: InkWell(
      onTap: onPress,
      child: Stack(
        children: [
          Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: Row(
                children: [
                  Image.asset(image, height: 40),
                  const SizedBox(width: 5),
                  Text(gender)
                ],
              ),
            ),
          ),
          Positioned(
            right: 5,
            top: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: const Text("Lựa chọn hiện tại"),
            ),
          )
        ],
      ),
    ),
  );
}
