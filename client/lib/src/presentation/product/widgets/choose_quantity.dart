import 'package:flutter/material.dart';

import 'custom_button_quantity.dart';

Widget chooseQuantity(int number, Function(int value) onChange) {
  return Container(
    color: const Color.fromRGBO(241, 241, 241, 1),
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
