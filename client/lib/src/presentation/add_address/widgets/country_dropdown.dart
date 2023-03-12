import 'package:coffee/src/controls/extension/string_extension.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CountryDropdown extends StatelessWidget {
  const CountryDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          hint: Text(
            'country'.translate(context),
            style: const TextStyle(fontSize: 16),
          ),
          items: ["Việt Nam"]
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ))
              .toList(),
          value: "Việt Nam",
          onChanged: (value) {},
          // dropdownMaxHeight: 250,
        ),
      ),
    );
  }
}
