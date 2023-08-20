import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_admin/src/core/utils/extensions/int_extension.dart';
import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:coffee_admin/src/data/remote/response/order/order_response.dart';
import 'package:coffee_admin/src/presentation/order/bloc/order_bloc.dart';
import 'package:coffee_admin/src/presentation/order/widgets/list_order_loading.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/route_function.dart';
import '../../../core/services/bloc/service_bloc.dart';
import '../../../core/services/bloc/service_event.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../data/models/preferences_model.dart';
import '../../../data/models/user.dart';
import '../../../data/remote/api_service/api_service.dart';
import '../../view_order/screen/view_order_page.dart';
import '../bloc/order_event.dart';
import '../bloc/order_state.dart';
import 'item_loading.dart';

class BodyOrder extends StatelessWidget {
  const BodyOrder({Key? key, required this.listOrder, required this.indexState})
      : super(key: key);

  final List<OrderResponse> listOrder;
  final int indexState;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is ChangeOrderListState) {
          listOrder.removeWhere((element) => element.orderId == state.id);
        }
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
                future: getUserInfo(context, listOrder[index].userId!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    User? user = snapshot.requireData;
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(createRoute(
                          screen: ViewOrderPage(
                            user: user,
                            order: listOrder[index],
                            onPress: () {
                              context.read<OrderBloc>().add(
                                  ChangeOrderListEvent(
                                      listOrder[index].orderId!));
                            },
                          ),
                          begin: const Offset(1, 0),
                        ));
                      },
                      child: itemOrder(context, listOrder[index], user),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return itemOrderLoading();
                  }
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(createRoute(
                        screen: ViewOrderPage(
                          user: null,
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
                    child: itemOrder(context, listOrder[index], null),
                  );
                },
              );
            },
          ),
        );
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
            order.selectedPickupStore != null
                ? order.selectedPickupStore!.storeName.toString()
                : order.getAddress(),
            // overflow: TextOverflow.ellipsis,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ],
    );
  }

  Future<User?> getUserInfo(BuildContext context, String id) async {
    PreferencesModel preferencesModel =
        context.read<ServiceBloc>().preferencesModel;
    try {
      User? user = preferencesModel.getUser(id);
      if (user == null) {
        ApiService apiService =
            ApiService(Dio(BaseOptions(contentType: "application/json")));
        // final prefs = await SharedPreferences.getInstance();
        // String token = prefs.getString("token") ?? "";
        final response = await apiService.getUserByID(
            'Bearer ${preferencesModel.token}', id);
        user = User.fromUserResponse(response.data);
        List<User> list = [user];
        list.addAll(preferencesModel.listUser);
        if (context.mounted) {
          context
              .read<ServiceBloc>()
              .add(SetDataEvent(preferencesModel.copyWith(listUser: list)));
        }
      }
      return user;
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      print(error);
    } catch (e) {
      print(e);
    }
    return null;
  }

  Widget bodyItem(BuildContext context, OrderResponse order, User? user) {
    return Row(
      children: [
        ClipOval(
          child: user == null || user.imageUrl == null
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
                user != null
                    ? user.displayName
                    : "coffee_users".translate(context),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                    "${"date_created".translate(context)}: ${order.createdDate}"),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                    "${"delivery_date".translate(context)}: ${order.lastUpdated}"),
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

  Widget itemOrder(BuildContext context, OrderResponse order, User? user) {
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
