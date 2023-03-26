import 'package:coffee/src/core/utils/constants/app_colors.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/presentation/voucher/screen/voucher_page.dart';
import 'package:flutter/material.dart';

import '../../../core/function/route_function.dart';

class AddCoupons extends StatefulWidget {
  const AddCoupons({Key? key}) : super(key: key);

  @override
  State<AddCoupons> createState() => _AddCouponsState();
}

class _AddCouponsState extends State<AddCoupons> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(createRoute(
                screen: const VoucherPage(),
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
          Container(
            margin: const EdgeInsets.fromLTRB(20, 5, 20, 15),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.bgColor,
              border: Border.all(color: AppColors.statusBarColor),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Miễn phí vận chuyển"),
                    SizedBox(height: 5),
                    Text("Hết hạn sau 10 giờ"),
                  ],
                ),
                const Spacer(),
                Text("already_applied".translate(context))
              ],
            ),
          )
        ],
      ),
    );
  }
}
