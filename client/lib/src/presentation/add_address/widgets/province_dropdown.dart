import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dvhcvn/dvhcvn.dart' as dvhcvn;
import 'package:flutter/material.dart';

Widget provinceDropdown({
  String? selectedValue,
  required Function(dvhcvn.Level1? value) onChange,
}) {
  return SizedBox(
    width: double.infinity,
    child: DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: const Text(
          'Tỉnh/Thành Phố',
          style: TextStyle(fontSize: 16),
        ),
        items: dvhcvn.level1s
            .map((item) => DropdownMenuItem<String>(
                  value: item.name,
                  child: Text(
                    item.name,
                    style: const TextStyle(fontSize: 16),
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          onChange(dvhcvn.findLevel1ByName(value as String));
        },
        dropdownMaxHeight: 250,
      ),
    ),
  );
}
