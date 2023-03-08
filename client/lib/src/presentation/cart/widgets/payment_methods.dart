import 'package:flutter/material.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({Key? key}) : super(key: key);

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
          Row(
            children: [
              const SizedBox(width: 10),
              Image.asset("assets/momo.png", width: 50),
              const SizedBox(width: 10),
              const Text("Ví điện tử momo"),
              const Spacer(),
              Radio(
                value: 1,
                groupValue: 1,
                onChanged: (value) {},
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 10),
              Image.asset("assets/cod.png", width: 50),
              const SizedBox(width: 10),
              const Text("Thanh toán khi nhận hàng"),
              const Spacer(),
              Radio(
                value: 2,
                groupValue: 1,
                onChanged: (value) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
