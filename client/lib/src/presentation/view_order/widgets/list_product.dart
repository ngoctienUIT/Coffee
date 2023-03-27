import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/constants/app_strings.dart';
import 'item_product.dart';

class ListProduct extends StatelessWidget {
  const ListProduct({Key? key, required this.onChange}) : super(key: key);
  final Function(int total) onChange;

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
