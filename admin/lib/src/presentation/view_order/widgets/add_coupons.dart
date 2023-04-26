import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../../../domain/repositories/coupon/coupon_response.dart';
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
                Text("promo_code".translate(context)),
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
        ],
      ),
    );
  }
}
