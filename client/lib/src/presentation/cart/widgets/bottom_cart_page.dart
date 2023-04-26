import 'package:coffee/src/core/utils/extensions/int_extension.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/domain/repositories/order/order_response.dart';
import 'package:coffee/src/presentation/cart/bloc/cart_bloc.dart';
import 'package:coffee/src/presentation/cart/bloc/cart_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/custom_toast.dart';
import '../../login/widgets/custom_button.dart';

class BottomCartPage extends StatelessWidget {
  const BottomCartPage({Key? key, required this.order}) : super(key: key);

  final OrderResponse order;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Text(
                "total".translate(context),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              Text(
                order.orderAmount!.toCurrency(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
            ],
          ),
          customButton(
            text: "order".translate(context),
            onPress: () {
              if (order.selectedPickupOption == "DELIVERY" &&
                  order.address1 == null) {
                customToast(context,
                    "please_enter_your_shipping_address".translate(context));
              } else if (order.selectedPickupOption == "AT_STORE" &&
                  order.selectedPickupStore == null) {
                customToast(context, "please_select_store".translate(context));
              } else {
                context.read<CartBloc>().add(PlaceOrder());
              }
            },
            isOnPress: true,
          ),
        ],
      ),
    );
  }
}
