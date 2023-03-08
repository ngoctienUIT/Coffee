import 'package:coffee/src/presentation/cart/widgets/add_coupons.dart';
import 'package:coffee/src/presentation/cart/widgets/bottom_cart_page.dart';
import 'package:coffee/src/presentation/cart/widgets/info_cart.dart';
import 'package:coffee/src/presentation/cart/widgets/list_product.dart';
import 'package:coffee/src/presentation/cart/widgets/payment_methods.dart';
import 'package:coffee/src/presentation/cart/widgets/total_payment.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
        elevation: 0,
        title: const Text(
          "Giỏ hàng",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton(onPressed: () {}, child: const Text("Xóa giỏ hàng")),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              infoCart(),
              const SizedBox(height: 10),
              const ListProduct(),
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
      bottomSheet: bottomCartPage(),
    );
  }
}
