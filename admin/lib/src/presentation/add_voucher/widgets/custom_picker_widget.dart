import 'package:coffee_admin/src/controls/extension/string_extension.dart';
import 'package:flutter/material.dart';

class CustomPickerWidget extends StatelessWidget {
  const CustomPickerWidget({
    Key? key,
    required this.text,
    required this.onPress,
  }) : super(key: key);

  final String text;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromRGBO(220, 220, 220, 1),
            width: 0.7,
          ),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Row(
          children: [
            Text(
              text,
              style:
                  TextStyle(fontSize: 16, color: Theme.of(context).hintColor),
            ),
            const Spacer(),
            Text(
              "select".translate(context),
              style: const TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
