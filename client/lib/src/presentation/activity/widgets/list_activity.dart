import 'package:coffee/src/core/services/bloc/service_bloc.dart';
import 'package:coffee/src/core/services/bloc/service_state.dart';
import 'package:coffee/src/core/utils/extensions/int_extension.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:coffee/src/data/remote/response/order/order_response.dart';
import 'package:coffee/src/presentation/activity/bloc/activity_bloc.dart';
import 'package:coffee/src/presentation/activity/bloc/activity_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../view_order/screen/view_order_page.dart';

class ListActivity extends StatelessWidget {
  const ListActivity(
      {Key? key, required this.listOrder, required this.indexState})
      : super(key: key);

  final List<OrderResponse> listOrder;
  final int indexState;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceBloc, ServiceState>(
        buildWhen: (previous, current) => current is CancelServiceOrderState,
        builder: (context, state) {
          if (state is CancelServiceOrderState) {
            listOrder.removeWhere((element) => element.orderId == state.id);
          }
          return RefreshIndicator(
            onRefresh: () async {
              context.read<ActivityBloc>().add(FetchData(indexState));
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              itemCount: listOrder.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(createRoute(
                      screen: ViewOrderPage(
                        index: indexState,
                        order: listOrder[index],
                      ),
                      begin: const Offset(0, 1),
                    ));
                  },
                  child: itemActivity(listOrder[index], context),
                );
              },
            ),
          );
        });
  }

  Widget itemActivity(OrderResponse order, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Image.asset(AppImages.imgLogo, height: 70),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      order.orderId.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.statusBarColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                      "${AppLocalizations.of(context).dateCreated}: ${order.lastUpdated}"),
                  const SizedBox(height: 10),
                  Text(
                      "${AppLocalizations.of(context).status}: ${order.orderStatus}"),
                  const SizedBox(height: 10),
                  Text(
                    "${AppLocalizations.of(context).totalOrder}: ${order.orderAmount!.toCurrency()}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.statusBarColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 5),
            const Icon(Icons.arrow_forward_ios_outlined)
          ],
        ),
      ),
    );
  }
}
