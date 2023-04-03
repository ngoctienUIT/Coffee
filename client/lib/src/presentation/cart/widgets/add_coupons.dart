import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/presentation/cart/bloc/cart_bloc.dart';
import 'package:coffee/src/presentation/cart/bloc/cart_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/route_function.dart';
import '../../../domain/repositories/coupon/coupon_response.dart';
import '../../coupon/screen/coupon_page.dart';
import '../../coupon/widgets/ticket_widget.dart';

class AddCoupons extends StatefulWidget {
  const AddCoupons({Key? key, this.coupons}) : super(key: key);

  final List<CouponResponse>? coupons;

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
                  onPress: (id) {
                    print(id);
                    context.read<CartBloc>().add(AttachCouponToOrder(id));
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
                  Text("promo_code".translate(context)),
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
              title: widget.coupons![0].couponName,
              image: widget.coupons![0].imageUrl,
              date: widget.coupons![0].dueDate,
            ),
          if (widget.coupons != null) const SizedBox(height: 10),
        ],
      ),
    );
  }
}
