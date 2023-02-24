import 'package:flutter/material.dart';

Widget itemOther(String text, IconData icon, Function onPress) {
  return InkWell(
    onTap: () => onPress(),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 10),
          Text(text),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios_rounded)
        ],
      ),
    ),
  );
}
