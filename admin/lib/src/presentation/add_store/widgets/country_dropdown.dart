import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/constants/constants.dart';

class CountryDropdown extends StatelessWidget {
  const CountryDropdown({Key? key}) : super(key: key);

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
            AppLocalizations.of(context)!.country,
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
