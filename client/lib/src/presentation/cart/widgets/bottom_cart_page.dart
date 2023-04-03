import 'package:coffee/src/core/utils/extensions/int_extension.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/presentation/cart/bloc/cart_bloc.dart';
import 'package:coffee/src/presentation/cart/bloc/cart_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../login/widgets/custom_button.dart';

class BottomCartPage extends StatelessWidget {
  const BottomCartPage({Key? key, required this.total}) : super(key: key);

  final int total;

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
                total.toCurrency(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
            ],
          ),
          customButton(
            text: "order".translate(context),
            onPress: () => context.read<CartBloc>().add(PlaceOrder()),
            isOnPress: true,
          ),
        ],
      ),
    );
  }
}
