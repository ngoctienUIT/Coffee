import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/data/models/product.dart';
import 'package:flutter/material.dart';

import 'item_product.dart';

class ListProduct extends StatelessWidget {
  const ListProduct({Key? key, required this.listProduct}) : super(key: key);

  final List<Product> listProduct;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Text(
              "list_products".translate(context),
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const Divider(),
          ListView.builder(
            padding: const EdgeInsets.only(bottom: 10),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listProduct.length,
            itemBuilder: (context, index) {
              return ItemProduct(index: index, product: listProduct[index]);
            },
          ),
        ],
      ),
    );
  }
}
