import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee/src/core/utils/constants/app_colors.dart';
import 'package:coffee/src/core/utils/extensions/int_extension.dart';
import 'package:coffee/src/data/models/product.dart';
import 'package:flutter/material.dart';

import '../../store/widgets/item_loading.dart';

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
    print(widget.product.chooseTopping);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.index != 0) const Divider(indent: 10, endIndent: 10),
          Row(
            children: [
              CachedNetworkImage(
                height: 50,
                width: 50,
                imageUrl: widget.product.image ?? "",
                placeholder: (context, url) => itemLoading(50, 50, 0),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
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
                    if (widget.product.isTopping())
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.product.toppingOptions!.length,
                        itemBuilder: (context, index) {
                          if (widget.product.chooseTopping![index]) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(widget
                                  .product.toppingOptions![index].toppingName),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                  ],
                ),
              ),
              Text(
                widget.product.getTotal().toCurrency(),
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
