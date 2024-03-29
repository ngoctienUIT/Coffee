import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../core/function/route_function.dart';
import '../../../data/models/coupon.dart';
import '../../coupon/screen/coupon_page.dart';
import '../../coupon/widgets/ticket_widget.dart';

class AddCoupons extends StatefulWidget {
  const AddCoupons(
      {Key? key, this.coupons, required this.onPress, required this.onDelete})
      : super(key: key);

  final Coupon? coupons;
  final Function(String id) onPress;
  final VoidCallback onDelete;

  @override
  State<AddCoupons> createState() => _AddCouponsState();
}

class _AddCouponsState extends State<AddCoupons> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(createRoute(
                screen: CouponPage(
                  id: widget.coupons != null ? widget.coupons!.id : null,
                  onDelete: () {
                    Navigator.pop(context);
                    widget.onDelete();
                  },
                  onPress: (id) {
                    Navigator.pop(context);
                    widget.onPress(id);
                  },
                ),
                begin: const Offset(1, 0),
              ));
            },
            child: Padding(
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
          ),
          if (widget.coupons != null)
            TicketWidget(
              height: 100,
              width: MediaQuery.of(context).size.width - 50,
              onPress: null,
              title: widget.coupons!.couponName,
              image: widget.coupons!.imageUrl.toString(),
              date: widget.coupons!.dueDate,
            ),
          if (widget.coupons != null) const SizedBox(height: 10),
        ],
      ),
    );
  }
}
