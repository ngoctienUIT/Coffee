import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dvhcvn/dvhcvn.dart' as dvhcvn;
import 'package:flutter/material.dart';

Widget wardDropdown({
  required String? provinceID,
  required String? districtID,
  String? selectedValue,
  required Function(dvhcvn.Level3? value) onChange,
}) {
  return SizedBox(
    width: double.infinity,
    child: DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: const Text(
          'Xã/Phường',
          style: TextStyle(fontSize: 16),
        ),
        items: provinceID != null && districtID != null
            ? dvhcvn
                .findLevel1ById(provinceID)!
                .findLevel2ById(districtID)!
                .children
                .map((item) => DropdownMenuItem<String>(
                      value: item.name,
                      child: Text(
                        item.name,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ))
                .toList()
            : [],
        value: selectedValue,
        onChanged: (value) {
          dvhcvn.Level3? ward = dvhcvn
              .findLevel1ById(provinceID!)!
              .findLevel2ById(districtID!)!
              .findLevel3ByName(value as String);
          onChange(ward);
        },
        dropdownMaxHeight: 250,
      ),
    ),
  );
}
