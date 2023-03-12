import 'package:coffee/src/controls/extension/string_extension.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dvhcvn/dvhcvn.dart' as dvhcvn;
import 'package:flutter/material.dart';

class WardDropdown extends StatelessWidget {
  const WardDropdown({
    Key? key,
    this.provinceID,
    this.districtID,
    this.selectedValue,
    required this.onChange,
  }) : super(key: key);

  final String? provinceID;
  final String? districtID;
  final String? selectedValue;
  final Function(dvhcvn.Level3? value) onChange;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          hint: Text(
            'ward'.translate(context),
            style: const TextStyle(fontSize: 16),
          ),
          items: provinceID != null && districtID != null
              ? dvhcvn
                  .findLevel1ById(provinceID!)!
                  .findLevel2ById(districtID!)!
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
}
