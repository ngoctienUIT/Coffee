import 'package:coffee_admin/src/core/utils/constants/app_images.dart';
import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import 'item_payment.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({Key? key, required this.value}) : super(key: key);

  final int value;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              "payment_methods".translate(context),
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const Divider(),
          itemPayment(
            value: 0,
            groupValue: value,
            image: AppImages.imgMomo,
            title: "momo_wallet".translate(context),
          ),
          itemPayment(
            value: 1,
            groupValue: value,
            image: AppImages.imgCOD,
            title: "payment_delivery".translate(context),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
