import 'package:coffee/src/core/utils/constants/app_images.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'item_payment.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({Key? key, required this.value}) : super(key: key);

  final int value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              AppLocalizations.of(context).paymentMethods,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const Divider(indent: 10, endIndent: 10),
          itemPayment(
            value: 0,
            groupValue: value,
            image: AppImages.imgMomo,
            title: AppLocalizations.of(context).momoWallet,
          ),
          itemPayment(
            value: 1,
            groupValue: value,
            image: AppImages.imgCOD,
            title: AppLocalizations.of(context).paymentDelivery,
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
