import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../../../data/models/product.dart';
import '../../../domain/repositories/item_order/item_order_response.dart';
import '../../../domain/repositories/order/order_response.dart';
import '../../forgot_password/widgets/app_bar_general.dart';
import '../widgets/add_coupons.dart';
import '../widgets/bottom_cart_page.dart';
import '../widgets/info_cart.dart';
import '../widgets/list_product.dart';
import '../widgets/payment_methods.dart';
import '../widgets/total_payment.dart';

class ViewOrderPage extends StatelessWidget {
  const ViewOrderPage({Key? key, required this.order, required this.onPress})
      : super(key: key);

  final OrderResponse order;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGeneral(
        title: "customer_name".translate(context),
        elevation: 0,
      ),
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
              if (order.appliedCoupons != null)
                AddCoupons(listCoupon: order.appliedCoupons!),
              if (order.appliedCoupons != null) const SizedBox(height: 10),
              TotalPayment(order: order),
              const SizedBox(height: 10),
              const PaymentMethods(value: 1),
              const SizedBox(height: 170),
            ],
          ),
        ),
      ),
      bottomSheet: order.orderStatus == "PLACED"
          ? BottomCartPage(
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
