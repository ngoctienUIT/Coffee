import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dvhcvn/dvhcvn.dart' as dvhcvn;
import 'package:flutter/material.dart';

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
    return SizedBox(
      width: double.infinity,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          hint: Text(
            AppLocalizations.of(context).provinceCity,
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
          dropdownStyleData: const DropdownStyleData(maxHeight: 250),
        ),
      ),
    );
  }
}
