import 'package:coffee_admin/src/core/utils/extensions/int_extension.dart';
import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../../../domain/repositories/order/order_response.dart';

class TotalPayment extends StatelessWidget {
  const TotalPayment({Key? key, required this.order}) : super(key: key);

  final OrderResponse order;

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
                Text(order.getTotal().toCurrency()),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text("discount_code".translate(context)),
                const Spacer(),
                Text((order.getTotal() - order.orderAmount!).toCurrency())
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text("total".translate(context)),
                const Spacer(),
                Text(order.orderAmount!.toCurrency()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
