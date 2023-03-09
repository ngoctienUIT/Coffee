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
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              "Phương thức thanh toán",
              style: TextStyle(fontSize: 16),
            ),
          ),
          const Divider(),
          itemPayment(
            onChange: (value) => setState(() => this.value = value!),
            onPress: () => setState(() => value = 0),
            value: 0,
            groupValue: value,
            image: "assets/momo.png",
            title: "Ví điện tử Momo",
          ),
          itemPayment(
            onChange: (value) => setState(() => this.value = value!),
            onPress: () => setState(() => value = 1),
            value: 1,
            groupValue: value,
            image: "assets/cod.png",
            title: "Thanh toán khi nhận hàng",
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
