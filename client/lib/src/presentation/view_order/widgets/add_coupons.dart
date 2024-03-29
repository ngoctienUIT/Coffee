import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../data/remote/response/coupon/coupon_response.dart';
import '../../coupon/widgets/ticket_widget.dart';

class AddCoupons extends StatelessWidget {
  const AddCoupons({Key? key, required this.coupon}) : super(key: key);
  final CouponResponse coupon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Row(
              children: [
                const Icon(Icons.local_activity, color: Colors.red),
                const SizedBox(width: 10),
                Text(AppLocalizations.of(context).promoCode),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios_outlined),
              ],
            ),
          ),
          TicketWidget(
            height: 100,
            width: MediaQuery.of(context).size.width - 50,
            onPress: null,
            title: coupon.couponName,
            image: coupon.imageUrl.toString(),
            date: coupon.dueDate,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
