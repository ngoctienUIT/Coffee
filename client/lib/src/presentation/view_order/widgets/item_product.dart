import 'package:coffee/src/core/utils/extensions/int_extension.dart';
import 'package:coffee/src/data/models/product.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/constants/constants.dart';

class ItemProduct extends StatelessWidget {
  const ItemProduct({Key? key, required this.index, required this.product})
      : super(key: key);
  final Product product;
  final int index;

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat.currency(locale: "vi_VI");

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (index != 0) const Divider(indent: 10, endIndent: 10),
          Row(
            children: [
              Image.network(product.image!, height: 50, width: 50),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Text(product.getTotal().toCurrency()),
                  ],
                ),
              ),
              Container(
                height: 35,
                width: 40,
                decoration: BoxDecoration(
                  color: AppColors.bgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "${product.getSize()} x ${product.number}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
