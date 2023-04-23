import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee/src/core/utils/extensions/int_extension.dart';
import 'package:coffee/src/data/models/product.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/constants/constants.dart';
import '../../store/widgets/item_loading.dart';

class ItemProduct extends StatelessWidget {
  const ItemProduct({Key? key, required this.index, required this.product})
      : super(key: key);
  final Product product;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (index != 0) const Divider(indent: 10, endIndent: 10),
          Row(
            children: [
              CachedNetworkImage(
                height: 50,
                width: 50,
                imageUrl: product.image ?? "",
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
                      product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (product.isTopping())
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: product.toppingOptions!.length,
                        itemBuilder: (context, index) {
                          if (product.chooseTopping![index]) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                product.toppingOptions![index].toppingName,
                                style: const TextStyle(
                                  color: AppColors.statusBarColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    Text(
                      product.getTotal().toCurrency(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.statusBarColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.bgColor,
                  borderRadius: BorderRadius.circular(15),
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
