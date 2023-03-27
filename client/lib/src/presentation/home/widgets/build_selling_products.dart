import 'package:flutter/material.dart';

import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/app_strings.dart';
import '../../product/screen/product_page.dart';

class BuildListSellingProducts extends StatelessWidget {
  const BuildListSellingProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: listSellingProducts.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(5),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(createRoute(
                  screen: ProductPage(index: index),
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
              Image.asset(
                listSellingProducts[index]["image"]!,
                height: 120,
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(listSellingProducts[index]["name"]!, maxLines: 2),
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
                    listSellingProducts[index]["price"]!,
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
