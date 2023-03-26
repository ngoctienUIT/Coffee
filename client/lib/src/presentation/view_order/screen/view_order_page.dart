import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/presentation/voucher/widgets/app_bar_general.dart';
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
              const InfoCart(isBringBack: true),
              const SizedBox(height: 10),
              ListProduct(onChange: (total) {}),
              const SizedBox(height: 10),
              const AddCoupons(),
              const SizedBox(height: 10),
              const TotalPayment(),
              const SizedBox(height: 10),
              const PaymentMethods(value: 1),
              const SizedBox(height: 170),
            ],
          ),
        ),
      ),
      bottomSheet: BottomCartPage(onPress: () {}),
    );
  }
}
