import 'package:coffee/src/controls/extension/string_extension.dart';
import 'package:coffee/src/presentation/cart/widgets/item_payment.dart';
import 'package:flutter/material.dart';

class PaymentMethods extends StatefulWidget {
  const PaymentMethods({Key? key}) : super(key: key);

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  int value = 0;

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
            onChange: (value) => setState(() => this.value = value!),
            onPress: () => setState(() => value = 0),
            value: 0,
            groupValue: value,
            image: "assets/momo.png",
            title: "momo_wallet".translate(context),
          ),
          itemPayment(
            onChange: (value) => setState(() => this.value = value!),
            onPress: () => setState(() => value = 1),
            value: 1,
            groupValue: value,
            image: "assets/cod.png",
            title: "payment_delivery".translate(context),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
