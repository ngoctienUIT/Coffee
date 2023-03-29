import 'package:coffee/src/domain/repositories/order/order_response.dart';
import 'package:coffee/src/presentation/activity/bloc/activity_bloc.dart';
import 'package:coffee/src/presentation/activity/bloc/activity_event.dart';
import 'package:coffee/src/presentation/activity/bloc/activity_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/route_function.dart';
import '../../view_order/screen/view_order_page.dart';

class ListActivity extends StatelessWidget {
  const ListActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivityBloc, ActivityState>(
      builder: (context, state) {
        if (state is InitState || state is ActivityLoading) {
          return _buildLoading();
        }
        if (state is ActivityError) {
          return Center(child: Text(state.message!));
        }
        if (state is ActivityLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<ActivityBloc>().add(FetchData());
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              itemCount: state.listOrder.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(createRoute(
                      screen: const ViewOrderPage(),
                      begin: const Offset(0, 1),
                    ));
                  },
                  child: itemActivity(state.listOrder[index]),
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  Widget itemActivity(OrderResponse order) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Image.asset("assets/tea.png", height: 50),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        order.orderId.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        order.orderAmount.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(order.status.toString()),
                      const Spacer(),
                      Text(order.createdDate.toString()),
                    ],
                  )
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
