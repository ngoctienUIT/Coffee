import 'package:coffee/src/presentation/cart/widgets/bottom_cart_page.dart';
import 'package:coffee/src/presentation/cart/widgets/info_cart.dart';
import 'package:coffee/src/presentation/cart/widgets/list_product.dart';
import 'package:coffee/src/presentation/cart/widgets/temporary_money.dart';
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
              listProduct(),
              const SizedBox(height: 10),
              temporaryMoney(),
              const SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Row(
                    children: const [
                      Text("Tổng cộng"),
                      Spacer(),
                      Text("54.000đ")
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 200),
            ],
          ),
        ),
      ),
      bottomSheet: bottomCartPage(),
    );
  }
}
