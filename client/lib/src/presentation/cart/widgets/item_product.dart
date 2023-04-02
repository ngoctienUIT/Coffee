import 'package:coffee/src/data/models/product.dart';
import 'package:flutter/material.dart';

import '../../product/widgets/choose_quantity.dart';

class ItemProduct extends StatefulWidget {
  const ItemProduct({Key? key, required this.product, required this.onChange})
      : super(key: key);

  final Product product;
  final Function(int value) onChange;

  @override
  State<ItemProduct> createState() => _ItemProductState();
}

class _ItemProductState extends State<ItemProduct> {
  int number = 1;

  @override
  void initState() {
    number = widget.product.number;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // if (widget.pro != 0)
          const Divider(indent: 10, endIndent: 10),
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
                      widget.product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Text(widget.product.getPriceString()),
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
