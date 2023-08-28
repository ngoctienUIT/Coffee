import 'package:coffee/src/core/utils/constants/app_images.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:coffee/src/presentation/cart/widgets/item_payment.dart';
import 'package:flutter/material.dart';

import '../../../core/function/custom_toast.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({Key? key}) : super(key: key);

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
          const Divider(),
          itemPayment(
            onChange: (value) {},
            onPress: () => customToast(context,
                AppLocalizations.of(context).momoPaymentFeatureNotYetLaunched),
            value: 0,
            groupValue: 1,
            image: AppImages.imgMomo,
            title: AppLocalizations.of(context).momoWallet,
          ),
          itemPayment(
            onChange: (value) {},
            onPress: () {},
            value: 1,
            groupValue: 1,
            image: AppImages.imgCOD,
            title: AppLocalizations.of(context).paymentDelivery,
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
