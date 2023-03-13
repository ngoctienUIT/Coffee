import 'package:coffee_admin/src/controls/extension/string_extension.dart';
import 'package:flutter/material.dart';

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
          Container(
            margin: const EdgeInsets.fromLTRB(20, 5, 20, 15),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(241, 241, 241, 1),
              border: Border.all(color: const Color.fromRGBO(177, 40, 48, 1)),
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
