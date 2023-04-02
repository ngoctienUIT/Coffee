import 'package:coffee/src/core/utils/constants/app_colors.dart';
import 'package:coffee/src/data/models/product.dart';
import 'package:flutter/material.dart';

class ItemProduct extends StatefulWidget {
  const ItemProduct({
    Key? key,
    required this.product,
    required this.onChange,
    required this.index,
  }) : super(key: key);

  final Product product;
  final int index;
  final Function(int value) onChange;

  @override
  State<ItemProduct> createState() => _ItemProductState();
}

class _ItemProductState extends State<ItemProduct> {
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
              widget.product.image == null
                  ? Image.asset("assets/tea.png", height: 50, width: 50)
                  : Image.network(widget.product.image!, height: 50, width: 50),
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
                    Text(
                      "${widget.product.number}×${widget.product.getSize()}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.statusBarColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                widget.product.getTotalString(),
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.statusBarColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
