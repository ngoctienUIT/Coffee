import 'package:coffee/src/core/utils/constants/app_colors.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/presentation/cart/bloc/cart_bloc.dart';
import 'package:coffee/src/presentation/cart/bloc/cart_event.dart';
import 'package:coffee/src/presentation/product/screen/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/function/route_function.dart';
import '../../../core/widgets/custom_alert_dialog.dart';
import '../../../data/models/item_order.dart';
import '../../../data/models/product.dart';
import 'item_product.dart';

class ListProduct extends StatelessWidget {
  const ListProduct(
      {Key? key, required this.onChange, required this.orderItems})
      : super(key: key);
  final Function(int total) onChange;
  final List<ItemOrder> orderItems;

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
                  onPressed: () => Navigator.pop(context),
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
            itemCount: orderItems.length,
            itemBuilder: (context, index) {
              final product = toProduct(orderItems[index]);
              product.chooseTopping =
                  List.filled(product.toppingOptions!.length, false);
              List<String> idS =
                  orderItems[index].toppings!.map((e) => e.toppingId).toList();
              for (int i = 0; i < product.toppingOptions!.length; i++) {
                if (idS.contains(product.toppingOptions![i].toppingId)) {
                  product.chooseTopping![i] = true;
                }
              }
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(createRoute(
                    screen: ProductPage(
                      product: product,
                      isEdit: true,
                      index: index,
                      // onPress: () {
                      // context.read<CartBloc>().add(GetOrderSpending());
                      // },
                    ),
                    begin: const Offset(0, 1),
                  ));
                },
                child: Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio: 0.15,
                    children: [
                      SlidableAction(
                        onPressed: (_) {
                          _showAlertDialog(
                            context,
                            product.name,
                            () => context
                                .read<CartBloc>()
                                .add(DeleteProductEvent(index)),
                          );
                        },
                        // backgroundColor: const Color.fromRGBO(231, 231, 231, 1),
                        foregroundColor: AppColors.statusBarColor,
                        icon: FontAwesomeIcons.trash,
                        // borderRadius: BorderRadius.circular(15),
                      ),
                    ],
                  ),
                  child: ItemProduct(
                    product: product,
                    index: index,
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

  Future _showAlertDialog(
      BuildContext context, String text, VoidCallback onPress) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return customAlertDialog(
          context: context,
          title: "confirm".translate(context),
          content:
              "${"do_you_want_to_remove".translate(context)} $text ${"from_your_cart".translate(context)}",
          onOK: () {
            onPress();
            Navigator.pop(context);
          },
        );
      },
    );
  }

  Product toProduct(ItemOrder item) {
    Product product = item.product!;
    product.number = item.quantity;
    product.sizeIndex = item.selectedSize;
    return product;
  }
}
