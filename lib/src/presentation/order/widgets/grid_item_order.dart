import 'package:flutter/material.dart';

import '../../../data/data_app.dart';
import '../../product/screen/product_page.dart';

Widget gridItemOrder() {
  return GridView.builder(
    gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    itemCount: listSellingProducts.length,
    itemBuilder: (context, index) {
      return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductPage(index: index),
              ));
        },
        child: itemOrder(index),
      );
    },
  );
}

Widget itemOrder(int index) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Image.asset(
            listSellingProducts[index]["image"]!,
            width: 80,
          ),
          const Spacer(),
          Text(
            listSellingProducts[index]["name"]!,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            listSellingProducts[index]["price"]!,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    ),
  );
}
