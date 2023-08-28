import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../signup/widgets/custom_text_input.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({
    Key? key,
    required this.nameController,
    required this.phoneController,
  }) : super(key: key);

  final TextEditingController nameController;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).contactInfo,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                  hint: AppLocalizations.of(context).fullName,
                  isBorder: false,
                ),
                const Divider(color: Colors.black26, height: 1),
                CustomTextInput(
                  controller: phoneController,
                  hint: AppLocalizations.of(context).phoneNumber,
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
