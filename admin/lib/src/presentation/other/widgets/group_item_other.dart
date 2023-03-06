import 'package:flutter/material.dart';

import '../../product/widgets/description_line.dart';

Widget groupItemOther(String description, List<Widget> list) {
  return Column(
    children: [
      const SizedBox(height: 20),
      descriptionLine(
        text: description,
        color: const Color.fromRGBO(80, 45, 30, 1),
      ),
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
