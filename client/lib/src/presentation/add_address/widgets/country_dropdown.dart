import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

Widget countryDropdown() {
  return SizedBox(
    width: double.infinity,
    child: DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: const Text(
          'Quốc Gia',
          style: TextStyle(fontSize: 16),
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
