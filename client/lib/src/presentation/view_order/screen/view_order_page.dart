import 'package:coffee/src/controls/extension/string_extension.dart';
import 'package:flutter/material.dart';

import '../widgets/add_coupons.dart';
import '../widgets/bottom_cart_page.dart';
import '../widgets/info_cart.dart';
import '../widgets/list_product.dart';
import '../widgets/payment_methods.dart';
import '../widgets/total_payment.dart';

class ViewOrderPage extends StatelessWidget {
  const ViewOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "customer_name".translate(context),
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const InfoCart(isBringBack: true),
              const SizedBox(height: 10),
              ListProduct(onChange: (total) {}),
              const SizedBox(height: 10),
              const AddCoupons(),
              const SizedBox(height: 10),
              const TotalPayment(),
              const SizedBox(height: 10),
              const PaymentMethods(value: 1),
              const SizedBox(height: 200),
            ],
          ),
        ),
      ),
      bottomSheet: BottomCartPage(onPress: () {}),
    );
  }
}
