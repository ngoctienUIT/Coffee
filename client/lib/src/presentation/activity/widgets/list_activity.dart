import 'dart:math';

import 'package:coffee/src/core/utils/extensions/int_extension.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/domain/repositories/order/order_response.dart';
import 'package:coffee/src/presentation/activity/bloc/activity_bloc.dart';
import 'package:coffee/src/presentation/activity/bloc/activity_event.dart';
import 'package:coffee/src/presentation/activity/bloc/activity_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../store/widgets/item_loading.dart';
import '../../view_order/screen/view_order_page.dart';

class ListActivity extends StatelessWidget {
  const ListActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActivityBloc, ActivityState>(
      listener: (context, state) {
        if (state is ActivityError) {
          customToast(context, state.message.toString());
        }
      },
      builder: (context, state) {
        if (state is ActivityLoaded || state is UpdateSuccess) {
          final listOrder = state is ActivityLoaded
              ? state.listOrder
              : (state as UpdateSuccess).listOrder;
          int indexState = state is ActivityLoaded
              ? state.index
              : (state as UpdateSuccess).index;
          if (listOrder.isNotEmpty) {
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
                          order: listOrder[indexState],
                          onPress: () {
                            context
                                .read<ActivityBloc>()
                                .add(UpdateData(indexState));
                          },
                        ),
                        begin: const Offset(0, 1),
                      ));
                    },
                    child: itemActivity(listOrder[index], context),
                  );
                },
              ),
            );
          }
          return Center(child: Text("no_data".translate(context)));
        }
        return _buildLoading();
      },
    );
  }

  Widget _buildLoading() {
    var rng = Random();
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      physics: const BouncingScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          child: Row(
            children: [
              const SizedBox(width: 10),
              itemLoading(70, 70, 0),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 8),
                    itemLoading(20, double.infinity, 10),
                    const SizedBox(height: 8),
                    itemLoading(15, 150, 10),
                    const SizedBox(height: 8),
                    itemLoading(15, 100, 10),
                    const SizedBox(height: 8),
                    itemLoading(20, rng.nextDouble() * 50 + 100, 10),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: const Icon(Icons.arrow_forward_ios_outlined),
              ),
              const SizedBox(width: 10),
            ],
          ),
        );
      },
    );
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
                      "${"date_created".translate(context)}: ${order.createdDate}"),
                  const SizedBox(height: 10),
                  Text("${"status".translate(context)}: ${order.orderStatus}"),
                  const SizedBox(height: 10),
                  Text(
                    "${"total_order".translate(context)}: ${order.orderAmount!.toCurrency()}",
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
