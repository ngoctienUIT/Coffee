import 'package:flutter/material.dart';

import 'custom_button_quantity.dart';

Widget chooseQuantity(int number, Function(int value) onChange) {
  return Container(
    color: Colors.transparent,
    child: Row(
      children: [
        customButtonQuantity(() {
          if (number > 0) onChange(--number);
        }, Icons.remove),
        SizedBox(width: 40, child: Center(child: Text("$number"))),
        customButtonQuantity(() => onChange(++number), Icons.add),
      ],
    ),
  );
}
