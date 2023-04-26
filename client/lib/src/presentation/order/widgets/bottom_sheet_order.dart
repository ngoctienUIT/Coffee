import 'package:coffee/src/core/utils/constants/app_colors.dart';
import 'package:coffee/src/core/utils/constants/app_images.dart';
import 'package:coffee/src/core/utils/enum/enums.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/domain/repositories/store/store_response.dart';
import 'package:coffee/src/presentation/add_address/screen/add_address_page.dart';
import 'package:coffee/src/presentation/home/widgets/cart_number.dart';
import 'package:coffee/src/presentation/main/bloc/main_bloc.dart';
import 'package:coffee/src/presentation/order/widgets/item_bottom_sheet.dart';
import 'package:coffee/src/presentation/order/widgets/title_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/function/route_function.dart';
import '../../cart/screen/cart_page.dart';
import '../../main/bloc/main_event.dart';
import '../../main/bloc/main_state.dart';
import '../../store/screen/store_page.dart';
import '../bloc/order_bloc.dart';
import '../bloc/order_event.dart';
import '../bloc/order_state.dart';

class BottomSheetOrder extends StatelessWidget {
  const BottomSheetOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      buildWhen: (previous, current) =>
          current is! RefreshOrderLoading &&
          current is! RefreshOrderLoaded &&
          current is! RefreshOrderError,
      builder: (context, state) {
        if (state is OrderLoaded || state is AddProductToCartLoaded) {
          final order = state is OrderLoaded
              ? state.order
              : (state as AddProductToCartLoaded).order;
          final store = state is OrderLoaded
              ? state.store
              : (state as AddProductToCartLoaded).store;
          bool isBringBack = state is OrderLoaded
              ? state.isBringBack
              : (state as AddProductToCartLoaded).isBringBack;
          String address = state is OrderLoaded
              ? state.address
              : (state as AddProductToCartLoaded).address;
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
                Expanded(
                  child: InkWell(
                    onTap: () => showMyBottomSheet(
                      context: context,
                      onPress: (isBring) {
                        SharedPreferences.getInstance().then((value) {
                          value.setBool("isBringBack", isBring);
                          context.read<OrderBloc>().add(AddProductToCart(true));
                          Navigator.pop(context);
                        });
                      },
                      onEditAtTable: () {
                        Navigator.of(context).push(createRoute(
                          screen: StorePage(
                            isPick: true,
                            onPress: (store) {
                              SharedPreferences.getInstance().then((value) {
                                value.setString("storeID", store.storeId);
                                value.setBool("isBringBack", false);
                                context
                                    .read<OrderBloc>()
                                    .add(AddProductToCart(true));
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
                                value.setString(
                                    "address", address.getAddress());
                                context
                                    .read<OrderBloc>()
                                    .add(AddProductToCart(true));
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
                                isBringBack
                                    ? address
                                    : store == null
                                        ? ""
                                        : store.storeName.toString(),
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
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(createRoute(
                      screen: CartPage(onChange: (status) {
                        context.read<OrderBloc>().add(AddProductToCart());
                        if (status == OrderStatus.placed) {
                          context.read<MainBloc>().add(UpdateActivityEvent());
                        }
                      }),
                      begin: const Offset(1, 0),
                    ));
                  },
                  child: BlocListener<MainBloc, MainState>(
                    listener: (context, state) {
                      if (state is ChangeCartOrderState) {
                        context.read<OrderBloc>().add(AddProductToCart());
                      }
                    },
                    child: SizedBox(
                      height: double.infinity,
                      child: cartNumber(
                          order == null ? 0 : order.orderItems!.length),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return _buildLoading(context);
      },
    );
  }

  Widget _buildLoading(BuildContext context) {
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
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "at_table".translate(context),
                  style: const TextStyle(color: Colors.white),
                ),
                const Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          SizedBox(
            height: double.infinity,
            child: cartNumber(0),
          ),
        ],
      ),
    );
  }

  void showMyBottomSheet({
    required BuildContext context,
    required Function(bool isBring) onPress,
    required VoidCallback onEditBringBack,
    required VoidCallback onEditAtTable,
    StoreResponse? store,
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
                      ? "please_select_store".translate(context)
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
