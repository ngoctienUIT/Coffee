import 'package:coffee/src/core/utils/constants/app_colors.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/function/route_function.dart';
import '../../../data/models/product.dart';
import '../../product/screen/product_page.dart';
import 'item_product.dart';

class ListProduct extends StatelessWidget {
  const ListProduct(
      {Key? key, required this.onChange, required this.listProduct})
      : super(key: key);
  final Function(int total) onChange;
  final List<Product> listProduct;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Row(
              children: [
                Text(
                  "list_products".translate(context),
                  style: const TextStyle(fontSize: 16),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text("add_product".translate(context)),
                )
              ],
            ),
          ),
          const Divider(),
          ListView.builder(
            padding: const EdgeInsets.only(bottom: 10),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listProduct.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(createRoute(
                    screen: ProductPage(product: listProduct[index]),
                    begin: const Offset(0, 1),
                  ));
                },
                child: Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio: 0.15,
                    children: [
                      SlidableAction(
                        onPressed: (context) {},
                        // backgroundColor: const Color.fromRGBO(231, 231, 231, 1),
                        foregroundColor: AppColors.statusBarColor,
                        icon: FontAwesomeIcons.trash,
                        // borderRadius: BorderRadius.circular(15),
                      ),
                    ],
                  ),
                  child: ItemProduct(
                    product: listProduct[index],
                    onChange: (value) {},
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
