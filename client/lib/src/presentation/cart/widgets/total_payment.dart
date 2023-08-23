import 'package:coffee/src/core/utils/extensions/int_extension.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../data/models/order.dart';

class TotalPayment extends StatelessWidget {
  const TotalPayment({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).prepareBill,
              style: const TextStyle(fontSize: 16),
            ),
            const Divider(),
            Row(
              children: [
                Text(AppLocalizations.of(context).subtotal),
                const Spacer(),
                Text(order.getTotal().toCurrency()),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(AppLocalizations.of(context).discountCode),
                const Spacer(),
                Text((order.getTotal() - order.orderAmount!).toCurrency())
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(AppLocalizations.of(context).total),
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
