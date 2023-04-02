import 'package:coffee/src/data/models/product.dart';
import 'package:coffee/src/presentation/product/screen/product_page.dart';
import 'package:flutter/material.dart';

import '../../../core/function/route_function.dart';
import '../../../domain/repositories/product/product_response.dart';

class ListItemOrder extends StatelessWidget {
  const ListItemOrder({Key? key, required this.listProduct}) : super(key: key);

  final List<ProductResponse> listProduct;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      itemCount: listProduct.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(createRoute(
              screen: ProductPage(
                isEdit: false,
                product: Product.fromProductResponse(listProduct[index]),
              ),
              begin: const Offset(0, 1),
            ));
          },
          child: itemOrder(index),
        );
      },
    );
  }

  Widget itemOrder(int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Row(
          children: [
            Image.network(
              listProduct[index].image!,
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
