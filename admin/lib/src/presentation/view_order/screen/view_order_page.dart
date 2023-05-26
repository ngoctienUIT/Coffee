import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:coffee_admin/src/presentation/view_order/bloc/view_order_bloc.dart';
import 'package:coffee_admin/src/presentation/view_order/bloc/view_order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/function/loading_animation.dart';
import '../../../core/services/bloc/service_bloc.dart';
import '../../../data/models/preferences_model.dart';
import '../../../data/models/product.dart';
import '../../../data/models/user.dart';
import '../../../domain/repositories/item_order/item_order_response.dart';
import '../../../domain/repositories/order/order_response.dart';
import '../../forgot_password/widgets/app_bar_general.dart';
import '../bloc/view_order_event.dart';
import '../widgets/add_coupons.dart';
import '../widgets/bottom_cart_page.dart';
import '../widgets/info_cart.dart';
import '../widgets/list_product.dart';
import '../widgets/payment_methods.dart';
import '../widgets/total_payment.dart';

class ViewOrderPage extends StatelessWidget {
  const ViewOrderPage({Key? key, this.order, this.onPress, this.user, this.id})
      : super(key: key);

  final OrderResponse? order;
  final User? user;
  final VoidCallback? onPress;
  final String? id;

  @override
  Widget build(BuildContext context) {
    PreferencesModel preferencesModel =
        context.read<ServiceBloc>().preferencesModel;
    return BlocProvider(
      create: order == null
          ? (context) =>
              ViewOrderBloc(preferencesModel)..add(GetOrderEvent(id!))
          : (context) => ViewOrderBloc(preferencesModel),
      child: ViewOrderView(id: id, order: order, onPress: onPress, user: user),
    );
  }
}

class ViewOrderView extends StatelessWidget {
  const ViewOrderView({Key? key, this.order, this.onPress, this.user, this.id})
      : super(key: key);

  final OrderResponse? order;
  final User? user;
  final VoidCallback? onPress;
  final String? id;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ViewOrderBloc, ViewOrderState>(
      listener: (context, state) {
        if (state is GetOrderSuccessState) Navigator.pop(context);
        if (state is LoadingState) loadingAnimation(context);
        if (state is CancelSuccessState) {
          if (onPress != null) onPress!.call();
          customToast(context, "order_canceled".translate(context));
          Navigator.pop(context);
          Navigator.pop(context);
        }
        if (state is CompletedSuccessState) {
          if (onPress != null) onPress!.call();
          customToast(context, "complete_orders".translate(context));
          Navigator.pop(context);
          Navigator.pop(context);
        }
        if (state is ErrorState) {
          customToast(context, state.error);
          Navigator.pop(context);
        }
      },
      child: order == null
          ? BlocBuilder<ViewOrderBloc, ViewOrderState>(
              builder: (context, state) {
                if (state is GetOrderSuccessState) {
                  return buildOrder(context, state.order, state.user);
                }
                return Scaffold(body: Container());
              },
            )
          : buildOrder(context, order!, user),
    );
  }

  Widget buildOrder(BuildContext context, OrderResponse order, User? user) {
    return Scaffold(
      appBar: AppBarGeneral(
        title:
            user != null ? user.displayName : "coffee_users".translate(context),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              InfoCart(
                isBringBack: order.address1 != null,
                order: order,
                user: user,
              ),
              const SizedBox(height: 10),
              ListProduct(orderItems: order.orderItems!),
              const SizedBox(height: 10),
              if (order.appliedCoupon != null)
                AddCoupons(coupon: order.appliedCoupon!),
              if (order.appliedCoupon != null) const SizedBox(height: 10),
              TotalPayment(order: order),
              const SizedBox(height: 10),
              const PaymentMethods(value: 1),
              const SizedBox(height: 200),
            ],
          ),
        ),
      ),
      bottomSheet: user != null && order.orderStatus == "PLACED"
          ? BottomCartPage(
              userID: user.id!,
              total: order.orderAmount!,
              id: order.orderId!,
              onPress: onPress,
            )
          : null,
    );
  }

  Product toProduct(ItemOrderResponse item) {
    Product product = Product.fromProductResponse(item.product);
    product.number = item.quantity;
    product.sizeIndex =
        item.selectedSize == "S" ? 0 : (item.selectedSize == "M" ? 1 : 2);
    return product;
  }
}
