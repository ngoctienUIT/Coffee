import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

class SetDefault extends StatelessWidget {
  const SetDefault({Key? key, required this.onChange, required this.value})
      : super(key: key);

  final Function(bool value) onChange;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "setting".translate(context),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Text(
                "set_default".translate(context),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Switch(
                value: value,
                onChanged: (value) => onChange(value),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ],
    );
  }
}
