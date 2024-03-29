import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:coffee/src/data/models/address.dart';
import 'package:coffee/src/presentation/add_address/widgets/app_bar_add_address.dart';
import 'package:coffee/src/presentation/add_address/widgets/edit_address.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/function/custom_toast.dart';
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
  TextEditingController addressController = TextEditingController();
  AddressAPI addressAPI = AddressAPI();

  @override
  void initState() {
    if (widget.address != null) {
      addressAPI = AddressAPI.fromAddress(widget.address!);
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
            child: EditAddress(
              addressAPI: addressAPI,
              addressController: addressController,
              onChange: (address) {
                setState(() => addressAPI = address);
              },
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: customButton(
            text: AppLocalizations.of(context).save,
            isOnPress: true,
            onPress: () async {
              final myAddress = addressAPI.copyWith(
                address: addressController.text,
                isWard: false,
                isProvince: false,
                isDistrict: false,
              );
              if (myAddress.checkNull()) {
                customToast(context,
                    AppLocalizations.of(context).pleaseEnterFullAddress);
              } else {
                widget.onSave(myAddress.toAddress());
                Navigator.pop(context);
                final prefs = await SharedPreferences.getInstance();
                prefs.setString("address", myAddress.toAddress().getAddress());
              }
            },
          ),
        ),
      ),
    );
  }
}
