import 'package:coffee/src/core/utils/constants/app_colors.dart';
import 'package:coffee/src/core/utils/constants/app_images.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/domain/repositories/store/store_response.dart';
import 'package:coffee/src/presentation/home/widgets/cart_number.dart';
import 'package:coffee/src/presentation/order/widgets/item_bottom_sheet.dart';
import 'package:coffee/src/presentation/order/widgets/title_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/function/route_function.dart';
import '../../cart/screen/cart_page.dart';
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
        if (state is InitState || state is OrderLoading) {
          return _buildLoading();
        }
        if (state is OrderError || state is AddProductToCartError) {
          String? message = state is OrderError
              ? state.message
              : (state as AddProductToCartError).message;
          return Center(child: Text(message.toString()));
        }
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
                    onTap: () => showMyBottomSheet(context, (isBring) {
                      Navigator.of(context).push(createRoute(
                        screen: StorePage(
                          isPick: true,
                          onPress: (store) {
                            SharedPreferences.getInstance().then((value) {
                              value.setString("storeID", store.storeId);
                              value.setBool("isBringBack", isBring);
                              context.read<OrderBloc>().add(AddProductToCart());
                              Navigator.pop(context);
                            });
                          },
                        ),
                        begin: const Offset(1, 0),
                      ));
                    }, store),
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
                            if (store != null)
                              Flexible(
                                child: Text(
                                  store.storeName.toString(),
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
                      screen: CartPage(
                        onChange: () {
                          context.read<OrderBloc>().add(AddProductToCart());
                        },
                      ),
                      begin: const Offset(1, 0),
                    ));
                  },
                  child: SizedBox(
                    height: double.infinity,
                    child: cartNumber(
                        order == null ? 0 : order.orderItems!.length),
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  void showMyBottomSheet(
    BuildContext context,
    Function(bool isBring) onPress,
    StoreResponse? store,
  ) {
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
                  onPress: () => onPress(false),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: itemBottomSheet(
                  title: "bring_back".translate(context),
                  content: store == null
                      ? "please_select_store".translate(context)
                      : '''${store.storeName}
${store.address1}, ${store.address2}, ${store.address3}, ${store.address4}''',
                  image: AppImages.imgLogo,
                  onPress: () => onPress(true),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
