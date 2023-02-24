import 'package:coffee/src/data/data_app.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/build_item_product.dart';
import '../widgets/build_selling_products.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(90),
          child: ClipOval(child: Image.asset("assets/coffee_logo.jpg")),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              FontAwesomeIcons.magnifyingGlass,
              color: Colors.grey,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          buildListItemProduct(),
          Container(
            margin: const EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            child: const Text(
              "Sản phẩm bán chạy",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          buildListSellingProducts(),
        ],
      ),
    );
  }

  Widget buildSpecialOffer() {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listSellingProducts.length,
        itemBuilder: (context, index) {
          return buildSellingProducts(index);
        },
      ),
    );
  }
}
