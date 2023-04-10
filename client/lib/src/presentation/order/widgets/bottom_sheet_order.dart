import 'package:coffee/src/core/utils/constants/app_colors.dart';
import 'package:coffee/src/core/utils/constants/app_images.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/presentation/home/widgets/cart_number.dart';
import 'package:coffee/src/presentation/order/widgets/item_bottom_sheet.dart';
import 'package:coffee/src/presentation/order/widgets/title_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/route_function.dart';
import '../../cart/screen/cart_page.dart';
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
                InkWell(
                  onTap: () => showMyBottomSheet(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                const Spacer(),
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

  void showMyBottomSheet(BuildContext context) {
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
                padding: const EdgeInsets.all(20),
                child: itemBottomSheet(
                  title: "at_table".translate(context),
                  content: "please_select_store".translate(context),
                  image: AppImages.imgLogo,
                  onPress: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: itemBottomSheet(
                  title: "bring_back".translate(context),
                  content: "please_select_store".translate(context),
                  image: AppImages.imgLogo,
                  onPress: () {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
