import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee/src/data/models/product.dart';
import 'package:flutter/material.dart';

import '../../../core/function/route_function.dart';
import '../../../domain/repositories/product/product_response.dart';
import '../../product/screen/product_page.dart';
import '../../store/widgets/item_loading.dart';

class BuildListSellingProducts extends StatelessWidget {
  const BuildListSellingProducts({Key? key, required this.listProduct})
      : super(key: key);

  final List<ProductResponse> listProduct;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: listProduct.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(5),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(createRoute(
                  screen: ProductPage(
                    isEdit: false,
                    product: Product.fromProductResponse(listProduct[index]),
                  ),
                  begin: const Offset(0, 1),
                ));
              },
              child: buildSellingProducts(index),
            ),
          );
        },
      ),
    );
  }

  Widget buildSellingProducts(int index) {
    return Card(
      child: SizedBox(
        width: 150,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              CachedNetworkImage(
                height: 120,
                width: 120,
                imageUrl: listProduct[index].image!,
                placeholder: (context, url) => itemLoading(120, 120, 0),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(listProduct[index].name, maxLines: 2),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(241, 233, 222, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "${listProduct[index].price}${listProduct[index].currency}",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
