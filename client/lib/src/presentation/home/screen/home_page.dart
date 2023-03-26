import 'package:coffee/src/core/utils/constants/app_colors.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/presentation/cart/screen/cart_page.dart';
import 'package:coffee/src/presentation/home/widgets/cart_number.dart';
import 'package:coffee/src/presentation/home/widgets/membership_card.dart';
import 'package:flutter/material.dart';

import '../../../core/function/route_function.dart';
import '../../activity/widgets/custom_app_bar.dart';
import '../widgets/build_item_product.dart';
import '../widgets/build_selling_products.dart';
import '../widgets/build_special_offer.dart';
import '../widgets/description_line.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: const CustomAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const MembershipCard(),
              const SizedBox(height: 10),
              buildListItemProduct(),
              const SizedBox(height: 20),
              descriptionLine(
                text: "promotion".translate(context),
                color: AppColors.textColor,
              ),
              buildListSpecialOffer(),
              const SizedBox(height: 20),
              descriptionLine(
                text: "selling_products".translate(context),
                color: AppColors.textColor,
              ),
              buildListSellingProducts(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(createRoute(
            screen: const CartPage(),
            begin: const Offset(1, 0),
          ));
        },
        backgroundColor: AppColors.statusBarColor,
        child: cartNumber(1),
      ),
    );
  }
}
