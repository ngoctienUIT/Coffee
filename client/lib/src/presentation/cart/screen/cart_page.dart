import 'package:coffee/src/data/models/cart.dart';
import 'package:coffee/src/presentation/cart/widgets/add_coupons.dart';
import 'package:coffee/src/presentation/cart/widgets/app_bar_cart.dart';
import 'package:coffee/src/presentation/cart/widgets/bottom_cart_page.dart';
import 'package:coffee/src/presentation/cart/widgets/info_cart.dart';
import 'package:coffee/src/presentation/cart/widgets/list_product.dart';
import 'package:coffee/src/presentation/cart/widgets/payment_methods.dart';
import 'package:coffee/src/presentation/cart/widgets/total_payment.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/constants/constants.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Cart cart = Cart(time: DateTime.now(), listProduct: []);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBarCart(clearCart: () {}),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const InfoCart(),
              const SizedBox(height: 10),
              ListProduct(onChange: (total) {}),
              const SizedBox(height: 10),
              const AddCoupons(),
              const SizedBox(height: 10),
              const TotalPayment(),
              const SizedBox(height: 10),
              const PaymentMethods(),
              const SizedBox(height: 200),
            ],
          ),
        ),
      ),
      bottomSheet: BottomCartPage(onPress: () {}),
    );
  }
}
