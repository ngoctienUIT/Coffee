import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../../../data/models/product.dart';
import '../../../domain/repositories/item_order/item_order_response.dart';
import 'item_product.dart';

class ListProduct extends StatelessWidget {
  const ListProduct({Key? key, required this.orderItems}) : super(key: key);

  final List<ItemOrderResponse> orderItems;

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
            itemCount: orderItems.length,
            itemBuilder: (context, index) {
              final product = toProduct(orderItems[index]);
              product.chooseTopping =
                  List.filled(product.toppingOptions!.length, false);
              List<String> idS =
                  orderItems[index].toppings.map((e) => e.toppingId).toList();
              for (int i = 0; i < product.toppingOptions!.length; i++) {
                if (idS.contains(product.toppingOptions![i].toppingId)) {
                  product.chooseTopping![i] = true;
                }
              }
              return ItemProduct(index: index, product: product);
            },
          ),
        ],
      ),
    );
  }

  Product toProduct(ItemOrderResponse item) {
    Product product = Product.fromProductResponse(item.product);
    product.number = item.quantity;
    product.sizeIndex =
        item.selectedSize == "S" ? 0 : (item.selectedSize == "M" ? 1 : 2);
    return product;
  }
}
