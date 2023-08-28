import 'package:coffee_admin/src/core/utils/extensions/int_extension.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:coffee_admin/src/presentation/view_order/bloc/view_order_bloc.dart';
import 'package:coffee_admin/src/presentation/view_order/bloc/view_order_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../login/widgets/custom_button.dart';

class BottomCartPage extends StatelessWidget {
  const BottomCartPage({
    Key? key,
    required this.total,
    required this.id,
    required this.userID,
    required this.onPress,
  }) : super(key: key);

  final int total;
  final String id;
  final String userID;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Text(
                AppLocalizations.of(context)!.total,
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
            text: AppLocalizations.of(context)!.orderCompleted,
            onPress: () => context
                .read<ViewOrderBloc>()
                .add(OrderCompletedEvent(id, userID)),
            isOnPress: true,
          ),
          customButton(
            text: AppLocalizations.of(context)!.cancelOrder,
            onPress: () =>
                context.read<ViewOrderBloc>().add(CancelOrderEvent(id, userID)),
            isOnPress: true,
          ),
        ],
      ),
    );
  }
}
