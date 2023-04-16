import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_admin/src/core/utils/extensions/int_extension.dart';
import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:coffee_admin/src/domain/entities/user/user_response.dart';
import 'package:coffee_admin/src/domain/repositories/order/order_response.dart';
import 'package:coffee_admin/src/presentation/order/bloc/order_bloc.dart';
import 'package:coffee_admin/src/presentation/order/bloc/order_state.dart';
import 'package:coffee_admin/src/presentation/order/widgets/list_order_loading.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../domain/api_service.dart';
import '../../view_order/screen/view_order_page.dart';
import '../bloc/order_event.dart';
import 'item_loading.dart';

class BodyOrder extends StatelessWidget {
  const BodyOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is OrderLoaded || state is RefreshLoaded) {
          List<OrderResponse> listOrder = state is OrderLoaded
              ? state.listOrder
              : (state as RefreshLoaded).listOrder;
          int indexState = state is OrderLoaded
              ? state.index
              : (state as RefreshLoaded).index;
          return RefreshIndicator(
            onRefresh: () async {
              context.read<OrderBloc>().add(RefreshData(indexState));
            },
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: listOrder.length,
              itemBuilder: (context, index) {
                return FutureBuilder(
                  future: getUserInfo(listOrder[index].userId!),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final user = snapshot.requireData;
                      print(user);
                      if (user != null) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(createRoute(
                              screen: ViewOrderPage(
                                user: user,
                                order: listOrder[index],
                                onPress: () {
                                  context
                                      .read<OrderBloc>()
                                      .add(RefreshData(indexState));
                                },
                              ),
                              begin: const Offset(1, 0),
                            ));
                          },
                          child: itemOrder(context, listOrder[index], user),
                        );
                      }
                      return const SizedBox.shrink();
                    }
                    return itemOrderLoading();
                  },
                );
              },
            ),
          );
        }
        return listOrderLoading();
      },
    );
  }

  Widget headerItem(OrderResponse order) {
    return Row(
      children: [
        CachedNetworkImage(
          height: 40,
          width: 40,
          fit: BoxFit.fitHeight,
          imageUrl:
              "https://www.highlandscoffee.com.vn/vnt_upload/news/02_2020/83739091_2845644318849727_1748210367038750720_o_1.png",
          placeholder: (context, url) => itemLoading(40, 40, 0),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
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

  Future<UserResponse?> getUserInfo(String id) async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      return (await apiService.getUserByID(id)).data;
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      print(error);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Widget bodyItem(
      BuildContext context, OrderResponse order, UserResponse user) {
    return Row(
      children: [
        ClipOval(
          child: user.imageUrl == null
              ? Image.asset(AppImages.imgNonAvatar, height: 100)
              : CachedNetworkImage(
                  height: 100,
                  width: 100,
                  imageUrl: user.imageUrl!,
                  placeholder: (context, url) => itemLoading(100, 100, 0),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
        ),
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
                  "${"total_order".translate(context)}: ${order.orderAmount!.toCurrency()}",
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget itemOrder(
      BuildContext context, OrderResponse order, UserResponse user) {
    int number = 0;
    for (var item in order.orderItems!) {
      number += item.quantity;
    }
    return Card(
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
            bodyItem(context, order, user),
            const Divider(),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "×$number ${"product".translate(context)}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.statusBarColor,
                  ),
                ),
                const Spacer(),
                Text(
                  "${"into_money".translate(context)}: ${order.orderAmount!.toCurrency()}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
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
