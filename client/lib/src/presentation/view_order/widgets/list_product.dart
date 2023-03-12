import 'package:coffee/src/controls/extension/string_extension.dart';
import 'package:flutter/material.dart';

import '../../../data/data_app.dart';
import 'item_product.dart';

class ListProduct extends StatelessWidget {
  const ListProduct({Key? key, required this.onChange}) : super(key: key);
  final Function(int total) onChange;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
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
            itemCount: listSellingProducts.length,
            itemBuilder: (context, index) {
              return ItemProduct(index: index, number: 1);
            },
          ),
        ],
      ),
    );
  }
}
