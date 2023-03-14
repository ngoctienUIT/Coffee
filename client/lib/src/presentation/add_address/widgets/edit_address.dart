import 'package:coffee/src/controls/extension/string_extension.dart';
import 'package:coffee/src/data/models/address.dart';
import 'package:flutter/material.dart';

import '../../signup/widgets/custom_text_input.dart';
import 'country_dropdown.dart';
import 'district_dropdown.dart';
import 'province_dropdown.dart';
import 'ward_dropdown.dart';

class EditAddress extends StatelessWidget {
  const EditAddress({
    Key? key,
    required this.addressAPI,
    required this.addressController,
    required this.onChange,
  }) : super(key: key);

  final AddressAPI addressAPI;
  final TextEditingController addressController;
  final Function(AddressAPI address) onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "edit_address".translate(context),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              children: [
                const CountryDropdown(),
                const Divider(color: Colors.black26, height: 1),
                ProvinceDropdown(
                  selectedValue: addressAPI.province != null
                      ? addressAPI.province!.name
                      : null,
                  onChange: (value) => onChange(addressAPI.copyWith(
                    province: value,
                    district: null,
                    ward: null,
                  )),
                ),
                const Divider(color: Colors.black26, height: 1),
                DistrictDropdown(
                  provinceID: addressAPI.province != null
                      ? addressAPI.province!.id
                      : null,
                  selectedValue: addressAPI.district != null
                      ? addressAPI.district!.name
                      : null,
                  onChange: (value) => onChange(addressAPI.copyWith(
                    province: addressAPI.province,
                    district: value,
                    ward: null,
                  )),
                ),
                const Divider(color: Colors.black26, height: 1),
                WardDropdown(
                  provinceID: addressAPI.province != null
                      ? addressAPI.province!.id
                      : null,
                  districtID: addressAPI.district != null
                      ? addressAPI.district!.id
                      : null,
                  selectedValue:
                      addressAPI.ward != null ? addressAPI.ward!.name : null,
                  onChange: (value) => onChange(addressAPI.copyWith(
                    province: addressAPI.province,
                    district: addressAPI.district,
                    ward: value,
                  )),
                ),
                const Divider(color: Colors.black26, height: 1),
                CustomTextInput(
                  contentPadding: const EdgeInsets.only(left: 15),
                  controller: addressController,
                  hint: "address".translate(context),
                  isBorder: false,
                ),
                const Divider(color: Colors.black26, height: 1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
