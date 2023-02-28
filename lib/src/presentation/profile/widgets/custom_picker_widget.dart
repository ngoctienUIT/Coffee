import 'package:flutter/material.dart';

class CustomPickerWidget extends StatelessWidget {
  const CustomPickerWidget({
    Key? key,
    required this.checkEdit,
    required this.text,
    this.onPress,
  }) : super(key: key);
  final bool checkEdit;
  final String text;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: checkEdit ? onPress : null,
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
            if (checkEdit)
              const Text(
                "chọn",
                style: TextStyle(color: Colors.blue),
              ),
          ],
        ),
      ),
    );
  }
}
