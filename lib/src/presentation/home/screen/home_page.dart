import 'package:coffee/src/presentation/cart/screen/cart_page.dart';
import 'package:coffee/src/presentation/home/widgets/cart_number.dart';
import 'package:coffee/src/presentation/home/widgets/membership_card.dart';
import 'package:coffee/src/presentation/search/screen/search_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../controls/route_function.dart';
import '../../profile/screen/profile_page.dart';
import '../widgets/build_item_product.dart';
import '../widgets/build_selling_products.dart';
import '../widgets/build_special_offer.dart';
import '../widgets/description_line.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        // elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).push(createRoute(
              screen: const ProfilePage(),
              begin: const Offset(1, 0),
            ));
          },
          borderRadius: BorderRadius.circular(90),
          child: ClipOval(child: Image.asset("assets/coffee_logo.jpg")),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(createRoute(
                screen: const SearchPage(),
                begin: const Offset(1, 0),
              ));
            },
            icon: const Icon(
              FontAwesomeIcons.magnifyingGlass,
              color: Colors.grey,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            membershipCard(),
            const SizedBox(height: 10),
            buildListItemProduct(),
            const SizedBox(height: 20),
            descriptionLine(
              text: "Khuyến mãi",
              color: const Color.fromRGBO(80, 45, 30, 1),
            ),
            buildListSpecialOffer(),
            const SizedBox(height: 20),
            descriptionLine(
              text: "Sản phẩm bán chạy",
              color: const Color.fromRGBO(80, 45, 30, 1),
            ),
            buildListSellingProducts(),
            const SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(createRoute(
            screen: const CartPage(),
            begin: const Offset(1, 0),
          ));
        },
        backgroundColor: const Color.fromRGBO(177, 40, 48, 1),
        child: cartNumber(1),
      ),
    );
  }
}
