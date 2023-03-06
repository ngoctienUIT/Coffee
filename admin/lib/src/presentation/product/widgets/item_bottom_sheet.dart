import 'package:flutter/material.dart';

Widget itemBottomSheet({
  required String title,
  required String content,
  required String image,
  required VoidCallback onPress,
}) {
  return InkWell(
    onTap: onPress,
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(15),
      ),
      height: 100,
      // margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          Image.asset(image, height: 90),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(content),
                const SizedBox(height: 10),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
