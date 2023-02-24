import 'package:flutter/material.dart';

import '../../home/widgets/description_line.dart';

Widget groupItemOther(String description, List<Widget> list) {
  return Column(
    children: [
      const SizedBox(height: 20),
      descriptionLine(description),
      const SizedBox(height: 10),
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(children: list),
        ),
      ),
    ],
  );
}
