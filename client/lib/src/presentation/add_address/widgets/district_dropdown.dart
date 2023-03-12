import 'package:coffee/src/controls/extension/string_extension.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dvhcvn/dvhcvn.dart' as dvhcvn;
import 'package:flutter/material.dart';

class DistrictDropdown extends StatelessWidget {
  const DistrictDropdown({
    Key? key,
    this.provinceID,
    this.selectedValue,
    required this.onChange,
  }) : super(key: key);

  final String? provinceID;
  final String? selectedValue;
  final Function(dvhcvn.Level2? value) onChange;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          hint: Text(
            'district'.translate(context),
            style: const TextStyle(fontSize: 16),
          ),
          items: provinceID != null
              ? dvhcvn
                  .findLevel1ById(provinceID!)!
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
            dvhcvn.Level2? district = dvhcvn
                .findLevel1ById(provinceID!)!
                .findLevel2ByName(value as String);
            onChange(district);
          },
          dropdownMaxHeight: 250,
        ),
      ),
    );
  }
}
