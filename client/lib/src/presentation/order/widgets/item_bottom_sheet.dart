import 'package:flutter/material.dart';

import '../../../core/utils/constants/app_colors.dart';

Widget itemBottomSheet({
  required String title,
  required String content,
  required String image,
  required VoidCallback onPress,
  required VoidCallback onEdit,
  required Color borderColor,
}) {
  return InkWell(
    onTap: onPress,
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(15),
      ),
      height: 110,
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
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: onEdit,
                      child: const Text(
                        "Sửa",
                        style: TextStyle(
                          color: AppColors.statusBarColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                const Spacer(),
                Text(
                  content,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
