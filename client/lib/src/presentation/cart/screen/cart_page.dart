import 'package:coffee/injection.dart';
import 'package:coffee/src/core/function/custom_toast.dart';
import 'package:coffee/src/core/function/loading_animation.dart';
import 'package:coffee/src/core/utils/enum/enums.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/core/widgets/custom_alert_dialog.dart';
import 'package:coffee/src/data/models/address.dart';
import 'package:coffee/src/presentation/cart/bloc/cart_bloc.dart';
import 'package:coffee/src/presentation/cart/bloc/cart_event.dart';
import 'package:coffee/src/presentation/cart/bloc/cart_state.dart';
import 'package:coffee/src/presentation/cart/widgets/add_coupons.dart';
import 'package:coffee/src/presentation/cart/widgets/app_bar_cart.dart';
import 'package:coffee/src/presentation/cart/widgets/bottom_cart_page.dart';
import 'package:coffee/src/presentation/cart/widgets/info_cart.dart';
import 'package:coffee/src/presentation/cart/widgets/list_product.dart';
import 'package:coffee/src/presentation/cart/widgets/payment_methods.dart';
import 'package:coffee/src/presentation/cart/widgets/total_payment.dart';
import 'package:coffee/src/presentation/login/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/bloc/service_bloc.dart';
import '../../../core/services/bloc/service_event.dart';
import '../../../core/services/bloc/service_state.dart';
import '../../../core/utils/constants/constants.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartBloc>(
      create: (context) => getIt<CartBloc>()..add(GetOrderSpending()),
      child: const CartView(),
    );
  }
}

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ServiceBloc, ServiceState>(
      listener: (context, state) {
        if (state is ChangeOrderState) {
          // context.read<CartBloc>().add(SetPreferencesModel(preferencesModel));
          context.read<CartBloc>().add(GetOrderSpending());
        }
      },
      child: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state is GetOrderSuccessState) {
            if (state.status != null) {
              if (state.status == OrderStatus.placed) {
                context.read<ServiceBloc>().add(PlacedOrderEvent());
                customToast(context, "order_success".translate(context));
              } else {
                customToast(
                    context, "cart_cleared_successfully".translate(context));
              }
              context.read<ServiceBloc>().add(ChangeOrderEvent(state.order));
            }
            if (state.isLoading) Navigator.pop(context);
          }
          if (state is GetOrderErrorState) {
            customToast(context, state.error);
            Navigator.pop(context);
          }
          if (state is GetOrderLoadingState) {
            loadingAnimation(context);
          }
          if (state is ChangeStoreCartState) {
            context.read<ServiceBloc>().add(ChangeStoreEvent());
          }
        },
        buildWhen: (previous, current) => current is GetOrderSuccessState,
        builder: (context, state) {
          print("cart page: $state");
          if (state is GetOrderSuccessState) {
            if (state.order == null) {
              return emptyCart(context);
            } else {
              print(state.order != null ? state.order!.toJson() : null);
              return buildBody(context, state);
            }
          }
          return Scaffold(body: Container());
        },
      ),
    );
  }

  Widget buildBody(BuildContext context, GetOrderSuccessState state) {
    Address? address;
    if (state.order!.address1 != null) {
      address = Address(
        province: state.order!.address4!,
        district: state.order!.address3!,
        ward: state.order!.address2!,
        address: state.order!.address1!,
      );
    }
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBarCart(
        clearCart: () => _showAlertDialog(context, () {
          context.read<CartBloc>().add(DeleteOrderEvent());
        }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              InfoCart(
                store: state.order?.selectedPickupStore,
                address: address,
                note: state.order?.orderNote,
                selectedPickupOption: state.order?.selectedPickupOption! ?? "",
              ),
              const SizedBox(height: 10),
              ListProduct(
                orderItems: state.order!.orderItems,
                onChange: (total) {},
              ),
              const SizedBox(height: 10),
              AddCoupons(
                coupons: state.order!.appliedCoupon,
                onDelete: () {
                  context.read<CartBloc>().add(DeleteCouponOrder());
                },
                onPress: (id) {
                  context.read<CartBloc>().add(AttachCouponToOrder(id));
                },
              ),
              const SizedBox(height: 10),
              TotalPayment(order: state.order!),
              const SizedBox(height: 10),
              const PaymentMethods(),
              const SizedBox(height: 200),
            ],
          ),
        ),
      ),
      bottomSheet: BottomCartPage(order: state.order!),
    );
  }

  Widget emptyCart(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "your_shopping_cart_is_empty".translate(context),
          style: const TextStyle(fontSize: 16),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(10),
        child: customButton(
          text: "ORDER_NOW".translate(context),
          isOnPress: true,
          onPress: () => Navigator.pop(context),
        ),
      ),
    );
  }

  Future _showAlertDialog(BuildContext context, VoidCallback onPress) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return customAlertDialog(
          context: context,
          title: "confirm".translate(context),
          content: "do_you_want_delete_all_items_your_cart".translate(context),
          onOK: () {
            onPress();
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
