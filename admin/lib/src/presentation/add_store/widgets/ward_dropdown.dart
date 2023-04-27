import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dvhcvn/dvhcvn.dart' as dvhcvn;
import 'package:flutter/material.dart';

import '../../../core/utils/constants/constants.dart';

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
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.borderColor, width: 0.7),
      ),
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
          dropdownStyleData: const DropdownStyleData(maxHeight: 250),
        ),
      ),
    );
  }
}
