import 'package:coffee/src/controls/extension/string_extension.dart';
import 'package:coffee/src/presentation/add_address/widgets/country_dropdown.dart';
import 'package:coffee/src/presentation/add_address/widgets/province_dropdown.dart';
import 'package:coffee/src/presentation/add_address/widgets/ward_dropdown.dart';
import 'package:coffee/src/presentation/signup/widgets/custom_text_input.dart';
import 'package:dvhcvn/dvhcvn.dart' as dvhcvn;
import 'package:flutter/material.dart';

import '../../login/widgets/custom_button.dart';
import '../widgets/district_dropdown.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  dvhcvn.Level1? province;
  dvhcvn.Level2? district;
  dvhcvn.Level3? ward;
  bool defaultAddress = false;
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
        elevation: 1,
        title: Text(
          "edit_address".translate(context),
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete, color: Colors.black),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "contact_info".translate(context),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        CustomTextInput(
                          controller: nameController,
                          hint: "full_name".translate(context),
                          isBorder: false,
                        ),
                        const Divider(color: Colors.black26, height: 1),
                        CustomTextInput(
                          controller: phoneController,
                          hint: "phone_number".translate(context),
                          isBorder: false,
                        ),
                        const Divider(color: Colors.black26, height: 1),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "edit_address".translate(context),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
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
                          selectedValue:
                              province != null ? province!.name : null,
                          onChange: (value) {
                            setState(() {
                              province = value;
                              district = null;
                              ward = null;
                            });
                          },
                        ),
                        const Divider(color: Colors.black26, height: 1),
                        DistrictDropdown(
                          provinceID: province != null ? province!.id : null,
                          selectedValue:
                              district != null ? district!.name : null,
                          onChange: (value) {
                            setState(() {
                              district = value;
                              ward = null;
                            });
                          },
                        ),
                        const Divider(color: Colors.black26, height: 1),
                        WardDropdown(
                          provinceID: province != null ? province!.id : null,
                          districtID: district != null ? district!.id : null,
                          selectedValue: ward != null ? ward!.name : null,
                          onChange: (value) {
                            setState(() => ward = value);
                          },
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
                const SizedBox(height: 10),
                Text(
                  "setting".translate(context),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        "set_default".translate(context),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Switch(
                        value: defaultAddress,
                        onChanged: (value) {
                          setState(() => defaultAddress = value);
                        },
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: customButton(
            text: "save".translate(context),
            isOnPress: true,
            onPress: () {},
          ),
        ),
      ),
    );
  }
}
