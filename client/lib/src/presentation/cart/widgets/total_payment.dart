import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

class TotalPayment extends StatelessWidget {
  const TotalPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "prepare_bill".translate(context),
              style: const TextStyle(fontSize: 16),
            ),
            const Divider(),
            Row(
              children: [
                Text("subtotal".translate(context)),
                const Spacer(),
                const Text("54.000đ"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text("discount_code".translate(context)),
                const Spacer(),
                const Text("54.000đ")
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text("total".translate(context)),
                const Spacer(),
                const Text("54.000đ"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
