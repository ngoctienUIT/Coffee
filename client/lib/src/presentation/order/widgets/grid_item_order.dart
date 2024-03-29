import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee/src/core/utils/extensions/int_extension.dart';
import 'package:coffee/src/data/models/product.dart';
import 'package:flutter/material.dart';

import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/app_colors.dart';
import '../../../data/remote/response/product/product_response.dart';
import '../../product/screen/product_page.dart';
import 'list_product_loading.dart';

class GridItemOrder extends StatelessWidget {
  const GridItemOrder({Key? key, required this.listProduct}) : super(key: key);

  final List<ProductResponse> listProduct;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
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
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CachedNetworkImage(
                height: 80,
                width: 80,
                imageUrl: listProduct[index].image ?? "",
                placeholder: (context, url) => itemProductLoading(80),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const Spacer(),
            Text(
              listProduct[index].name,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              listProduct[index].price.toCurrency(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.statusBarColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
