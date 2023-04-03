import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/data/models/address.dart';
import 'package:coffee/src/presentation/add_address/widgets/app_bar_add_address.dart';
import 'package:coffee/src/presentation/add_address/widgets/contact_info.dart';
import 'package:coffee/src/presentation/add_address/widgets/edit_address.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/constants/constants.dart';
import '../../login/widgets/custom_button.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key, required this.onSave, this.address})
      : super(key: key);

  final Function(Address address) onSave;
  final Address? address;

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  AddressAPI addressAPI = AddressAPI();

  @override
  void initState() {
    if (widget.address != null) {
      addressAPI = AddressAPI.fromAddress(widget.address!);
      nameController.text = widget.address!.name;
      phoneController.text = widget.address!.phone;
      addressController.text = widget.address!.address;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: const AppBarAddAddress(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ContactInfo(
                  nameController: nameController,
                  phoneController: phoneController,
                ),
                const SizedBox(height: 10),
                EditAddress(
                  addressAPI: addressAPI,
                  addressController: addressController,
                  onChange: (address) {
                    setState(() => addressAPI = address);
                  },
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
            onPress: () {
              widget.onSave(addressAPI
                  .copyWith(
                    name: nameController.text,
                    phone: phoneController.text,
                    address: addressController.text,
                  )
                  .toAddress());
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
