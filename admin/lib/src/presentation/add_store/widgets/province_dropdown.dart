import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dvhcvn/dvhcvn.dart' as dvhcvn;
import 'package:flutter/material.dart';

import '../../../core/utils/constants/constants.dart';

class ProvinceDropdown extends StatelessWidget {
  const ProvinceDropdown({
    Key? key,
    this.selectedValue,
    required this.onChange,
  }) : super(key: key);

  final String? selectedValue;
  final Function(dvhcvn.Level1? value) onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.borderColor, width: 0.7),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          hint: Text(
            'province_city'.translate(context),
            style: const TextStyle(fontSize: 16),
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
}
