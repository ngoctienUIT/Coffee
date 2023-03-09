import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/data_app.dart';
import '../../product/widgets/choose_quantity.dart';

class ItemProduct extends StatefulWidget {
  const ItemProduct({Key? key, required this.index, required this.onChange})
      : super(key: key);

  final int index;
  final Function(int value) onChange;

  @override
  State<ItemProduct> createState() => _ItemProductState();
}

class _ItemProductState extends State<ItemProduct> {
  int number = 1;
  final numberFormat = NumberFormat.currency(locale: "vi_VI");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.index != 0) const Divider(indent: 10, endIndent: 10),
          Row(
            children: [
              Image.asset("assets/tea.png", height: 50, width: 50),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      listSellingProducts[widget.index]["name"]!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Text(numberFormat.format(30000 * number)),
                  ],
                ),
              ),
              chooseQuantity(number, (value) => setState(() => number = value)),
            ],
          ),
        ],
      ),
    );
  }
}
