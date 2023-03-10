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
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              "Phương thức thanh toán",
              style: TextStyle(fontSize: 16),
            ),
          ),
          const Divider(),
          itemPayment(
            value: 0,
            groupValue: value,
            image: "assets/momo.png",
            title: "Ví điện tử Momo",
          ),
          itemPayment(
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
