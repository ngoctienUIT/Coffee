import 'package:coffee/src/presentation/product/screen/product_page.dart';
import 'package:flutter/material.dart';

import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/app_strings.dart';
import '../../../domain/repositories/product/product_response.dart';

class ListItemOrder extends StatelessWidget {
  const ListItemOrder({Key? key, required this.listProduct}) : super(key: key);

  final List<ProductResponse> listProduct;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: listProduct.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(createRoute(
                screen: ProductPage(index: index),
                begin: const Offset(0, 1),
              ));
            },
            child: itemOrder(index),
          );
        },
      ),
    );
  }

  Widget itemOrder(int index) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Row(
          children: [
            Image.asset(
              listSellingProducts[index]["image"]!,
              height: 100,
              width: 100,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listProduct[index].name,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    listProduct[index].description.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 5),
            SizedBox(
              width: 70,
              child: Text(
                "${listProduct[index].price}${listProduct[index].currency}",
                style: const TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
