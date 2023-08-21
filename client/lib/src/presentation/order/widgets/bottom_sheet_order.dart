import 'package:coffee/injection.dart';
import 'package:coffee/src/core/services/bloc/service_state.dart';
import 'package:coffee/src/core/utils/constants/app_colors.dart';
import 'package:coffee/src/core/utils/constants/app_images.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/presentation/add_address/screen/add_address_page.dart';
import 'package:coffee/src/presentation/home/widgets/cart_number.dart';
import 'package:coffee/src/presentation/order/widgets/item_bottom_sheet.dart';
import 'package:coffee/src/presentation/order/widgets/title_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/function/route_function.dart';
import '../../../core/services/bloc/service_bloc.dart';
import '../../../core/services/bloc/service_event.dart';
import '../../../data/models/order.dart';
import '../../../data/models/store.dart';
import '../../cart/screen/cart_page.dart';
import '../../store/screen/store_page.dart';
import '../bloc/order_bloc.dart';
import '../bloc/order_state.dart';

class BottomSheetOrder extends StatelessWidget {
  const BottomSheetOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      buildWhen: (previous, current) =>
          current is! RefreshOrderLoading &&
          current is! RefreshOrderLoaded &&
          current is! OrderError,
      builder: (context, state) {
        // Order? order = preferencesModel.order;
        // if (state is AddProductToCartLoaded) {
        //   order = state.order != null
        //       ? Order.fromOrderResponse(state.order!)
        //       : null;
        // }
        return Container(
          width: double.infinity,
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(color: AppColors.statusBarColor),
          child: Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              Expanded(child: infoStore()),
              itemCart(),
            ],
          ),
        );
        // return _buildLoading(context);
      },
    );
  }

  Widget itemCart() {
    return BlocBuilder<ServiceBloc, ServiceState>(
      buildWhen: (previous, current) =>
          current is ChangeOrderState || current is ChangeStoreState,
      builder: (context, state) {
        Order? order =
            getIt.isRegistered(instance: Order) ? getIt<Order>() : null;
        return InkWell(
          onTap: () {
            Navigator.of(context).push(createRoute(
              screen: const CartPage(),
              begin: const Offset(1, 0),
            ));
          },
          child: SizedBox(
            height: double.infinity,
            child: cartNumber(order == null ? 0 : order.orderItems.length),
          ),
        );
      },
    );
  }

  Widget infoStore() {
    return BlocBuilder<ServiceBloc, ServiceState>(
      buildWhen: (previous, current) =>
          current is ChangeOrderState || current is ChangeStoreState,
      builder: (context, state) {
        final sharedPref = getIt<SharedPreferences>();
        Store? store = getIt<Store>();
        bool isBringBack = sharedPref.getBool("isBringBack") ?? false;
        String address = sharedPref.getString("address") ?? "";
        return InkWell(
          onTap: () => showMyBottomSheet(
            context: context,
            onPress: (isBring) {
              SharedPreferences.getInstance().then((value) {
                value.setBool("isBringBack", isBring);
                context.read<ServiceBloc>().add(ChangeStoreEvent());
                Navigator.pop(context);
              });
            },
            onEditAtTable: () {
              Navigator.of(context).push(createRoute(
                screen: StorePage(
                  isPick: true,
                  onPress: (store) {
                    SharedPreferences.getInstance().then((value) {
                      value.setString("storeID", store.storeId!);
                      value.setBool("isBringBack", false);
                      context.read<ServiceBloc>().add(ChangeStoreEvent());
                      Navigator.pop(context);
                    });
                  },
                ),
                begin: const Offset(1, 0),
              ));
            },
            onEditBringBack: () {
              Navigator.of(context).push(createRoute(
                screen: AddAddressPage(
                  onSave: (address) {
                    SharedPreferences.getInstance().then((value) {
                      value.setBool("isBringBack", true);
                      value.setString("address", address.getAddress());
                      context.read<ServiceBloc>().add(ChangeStoreEvent());
                      Navigator.pop(context);
                    });
                  },
                  address: address.isNotEmpty
                      ? address.toAddressAPI().toAddress()
                      : null,
                ),
                begin: const Offset(1, 0),
              ));
            },
            store: store,
            address: address,
            isBringBack: isBringBack,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isBringBack
                    ? "bring_back".translate(context)
                    : "at_table".translate(context),
                style: const TextStyle(color: Colors.white),
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      isBringBack ? address : store.storeName.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Widget _buildLoading(BuildContext context) {
  //   return Container(
  //     width: double.infinity,
  //     height: 56,
  //     padding: const EdgeInsets.symmetric(horizontal: 10),
  //     decoration: const BoxDecoration(color: AppColors.statusBarColor),
  //     child: Row(
  //       children: [
  //         const Icon(Icons.location_on, color: Colors.white),
  //         const SizedBox(width: 10),
  //         Expanded(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 "at_table".translate(context),
  //                 style: const TextStyle(color: Colors.white),
  //               ),
  //               const Icon(
  //                 Icons.keyboard_arrow_down_outlined,
  //                 color: Colors.white,
  //               ),
  //             ],
  //           ),
  //         ),
  //         SizedBox(
  //           height: double.infinity,
  //           child: cartNumber(0),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  void showMyBottomSheet({
    required BuildContext context,
    required Function(bool isBring) onPress,
    required VoidCallback onEditBringBack,
    required VoidCallback onEditAtTable,
    Store? store,
    required String address,
    required bool isBringBack,
  }) {
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
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: itemBottomSheet(
                  title: "at_table".translate(context),
                  content: store == null
                      ? "please_select_store".translate(context)
                      : '''${store.storeName}
${store.address1}, ${store.address2}, ${store.address3}, ${store.address4}''',
                  image: AppImages.imgLogo,
                  borderColor: isBringBack
                      ? AppColors.borderColor
                      : AppColors.statusBarColor,
                  onPress: () => onPress(false),
                  onEdit: onEditAtTable,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: itemBottomSheet(
                  title: "bring_back".translate(context),
                  content: address.isEmpty
                      ? "please_select_the_address".translate(context)
                      : address,
                  image: AppImages.imgLogo,
                  borderColor: isBringBack
                      ? AppColors.statusBarColor
                      : AppColors.borderColor,
                  onPress: () => onPress(true),
                  onEdit: onEditBringBack,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
