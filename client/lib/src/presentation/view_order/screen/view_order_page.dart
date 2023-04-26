import 'package:coffee/src/core/function/custom_toast.dart';
import 'package:coffee/src/core/function/loading_animation.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/presentation/view_order/bloc/view_order_bloc.dart';
import 'package:coffee/src/presentation/view_order/bloc/view_order_event.dart';
import 'package:coffee/src/presentation/view_order/bloc/view_order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/product.dart';
import '../../../domain/repositories/item_order/item_order_response.dart';
import '../../../domain/repositories/order/order_response.dart';
import '../../coupon/widgets/app_bar_general.dart';
import '../widgets/add_coupons.dart';
import '../widgets/bottom_cart_page.dart';
import '../widgets/info_cart.dart';
import '../widgets/list_product.dart';
import '../widgets/payment_methods.dart';
import '../widgets/total_payment.dart';

class ViewOrderPage extends StatelessWidget {
  const ViewOrderPage(
      {Key? key, this.order, this.onPress, required this.index, this.id})
      : super(key: key);

  final OrderResponse? order;
  final VoidCallback? onPress;
  final int index;
  final String? id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: order == null
          ? (context) => ViewOrderBloc()..add(GetOrderEvent(id!))
          : (context) => ViewOrderBloc(),
      child:
          ViewOrderView(index: index, id: id, onPress: onPress, order: order),
    );
  }
}

class ViewOrderView extends StatelessWidget {
  const ViewOrderView(
      {Key? key, this.order, this.onPress, required this.index, this.id})
      : super(key: key);
  final OrderResponse? order;
  final VoidCallback? onPress;
  final int index;
  final String? id;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ViewOrderBloc, ViewOrderState>(
      listener: (context, state) {
        if (state is ViewOrderLoading) {
          loadingAnimation(context);
        }
        if (state is ViewOrderSuccess) {
          Navigator.pop(context);
        }
        if (state is ViewOrderError) {
          customToast(context, state.error);
        }
        if (state is CancelOrderSuccess) {
          onPress!();
          Navigator.pop(context);
          Navigator.pop(context);
        }
      },
      child: order == null
          ? BlocBuilder<ViewOrderBloc, ViewOrderState>(
              builder: (context, state) {
                if (state is ViewOrderSuccess) {
                  return buildOrder(context, state.order);
                }
                return Scaffold(body: Container());
              },
            )
          : buildOrder(context, order!),
    );
  }

  Widget buildOrder(BuildContext context, OrderResponse order) {
    return Scaffold(
      appBar: AppBarGeneral(title: "order2".translate(context), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              InfoCart(isBringBack: order.address1 != null, order: order),
              const SizedBox(height: 10),
              ListProduct(orderItems: order.orderItems!),
              const SizedBox(height: 10),
              if (order.appliedCoupon != null)
                AddCoupons(coupon: order.appliedCoupon!),
              if (order.appliedCoupon != null) const SizedBox(height: 10),
              TotalPayment(order: order),
              const SizedBox(height: 10),
              const PaymentMethods(value: 1),
              const SizedBox(height: 170),
            ],
          ),
        ),
      ),
      bottomSheet: index == 0
          ? BottomCartPage(total: order.orderAmount!, id: order.orderId!)
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
