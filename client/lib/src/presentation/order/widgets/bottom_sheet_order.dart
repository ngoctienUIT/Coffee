import 'package:coffee/src/controls/extension/string_extension.dart';
import 'package:coffee/src/presentation/home/widgets/cart_number.dart';
import 'package:coffee/src/presentation/order/widgets/item_bottom_sheet.dart';
import 'package:coffee/src/presentation/order/widgets/title_bottom_sheet.dart';
import 'package:flutter/material.dart';

import '../../../controls/route_function.dart';
import '../../cart/screen/cart_page.dart';

class BottomSheetOrder extends StatelessWidget {
  const BottomSheetOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(color: Color.fromRGBO(177, 40, 48, 1)),
      child: Row(
        children: [
          const Icon(
            Icons.location_on,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () => showMyBottomSheet(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "at_table".translate(context),
                  style: const TextStyle(color: Colors.white),
                ),
                const Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              Navigator.of(context).push(createRoute(
                screen: const CartPage(),
                begin: const Offset(1, 0),
              ));
            },
            child: SizedBox(
              height: double.infinity,
              child: cartNumber(1),
            ),
          ),
        ],
      ),
    );
  }

  void showMyBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      builder: (context) {
        return Container(
          height: 350,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              titleBottomSheet(
                "choose_delivery_method".translate(context),
                () => Navigator.pop(context),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: itemBottomSheet(
                  title: "at_table".translate(context),
                  content: "please_select_store".translate(context),
                  image: "assets/coffee_logo.jpg",
                  onPress: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: itemBottomSheet(
                  title: "bring_back".translate(context),
                  content: "please_select_store".translate(context),
                  image: "assets/coffee_logo.jpg",
                  onPress: () {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
