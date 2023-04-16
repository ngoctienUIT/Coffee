import 'package:coffee/src/core/utils/constants/app_images.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
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
              "payment_methods".translate(context),
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const Divider(),
          itemPayment(
            onChange: (value) {},
            onPress: () => customToast(
                context, "Tính năng thanh toán Momo chưa ra mắt"),
            value: 0,
            groupValue: 1,
            image: AppImages.imgMomo,
            title: "momo_wallet".translate(context),
          ),
          itemPayment(
            onChange: (value) {},
            onPress: () {},
            value: 1,
            groupValue: 1,
            image: AppImages.imgCOD,
            title: "payment_delivery".translate(context),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
