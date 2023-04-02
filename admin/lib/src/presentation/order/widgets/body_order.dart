import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:coffee_admin/src/domain/entities/user/user_response.dart';
import 'package:coffee_admin/src/domain/repositories/order/order_response.dart';
import 'package:coffee_admin/src/presentation/order/bloc/order_bloc.dart';
import 'package:coffee_admin/src/presentation/order/bloc/order_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../domain/api_service.dart';
import '../../view_order/screen/view_order_page.dart';
import '../bloc/order_event.dart';

class BodyOrder extends StatelessWidget {
  const BodyOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is InitState ||
            state is OrderLoading ||
            state is RefreshLoading) {
          return _buildLoading();
        }
        if (state is OrderError || state is RefreshError) {
          return Center(
            child: Text(state is OrderError
                ? state.message!
                : (state as RefreshError).message!),
          );
        }
        if (state is OrderLoaded || state is RefreshLoaded) {
          List<OrderResponse> listOrder = state is OrderLoaded
              ? state.listOrder
              : (state as RefreshLoaded).listOrder;
          return RefreshIndicator(
            onRefresh: () async {
              int index = state is OrderLoaded
                  ? state.index
                  : (state as RefreshLoaded).index;
              context.read<OrderBloc>().add(RefreshData(index));
            },
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: listOrder.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(createRoute(
                      screen: const ViewOrderPage(),
                      begin: const Offset(1, 0),
                    ));
                  },
                  child: itemOrder(context, listOrder[index]),
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

  Widget headerItem(OrderResponse order) {
    return Row(
      children: [
        Image.asset(AppImages.imgVietNam, height: 40),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            order.selectedPickupStore!.storeName.toString(),
            // overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Future<UserResponse> getUserInfo(String id) async {
    ApiService apiService =
        ApiService(Dio(BaseOptions(contentType: "application/json")));
    return await apiService.getUserByID(id);
  }

  Widget bodyItem(OrderResponse order) {
    return FutureBuilder<UserResponse>(
      future: getUserInfo(order.userId!),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final user = snapshot.requireData;
          return Row(
            children: [
              user.imageUrl == null
                  ? Image.asset("assets/tea.png", height: 100)
                  : Image.network(user.imageUrl!, height: 100),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.displayName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text("Ngày tạo: ${order.createdDate}"),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text("Ngày giao: ${order.lastUpdated}"),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "${"total_order".translate(context)}: ${order.orderAmount}đ",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        return _buildLoading();
      },
    );
  }

  Widget itemOrder(BuildContext context, OrderResponse order) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        // margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            headerItem(order),
            const Divider(),
            bodyItem(order),
            const Divider(),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "${"into_money".translate(context)}: 500.000đ",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            Row(
              children: [
                Text("delivery_status".translate(context)),
                const Spacer(),
                Text(
                  // "delivered".translate(context).toUpperCase(),
                  order.orderStatus.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
