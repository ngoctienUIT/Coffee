import 'package:coffee/src/presentation/cart/widgets/custom_button_quantity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../data/data_app.dart';

class ListProduct extends StatelessWidget {
  const ListProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Row(
              children: [
                const Text(
                  "Danh sách sản phẩm",
                  style: TextStyle(fontSize: 16),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text("Thêm sản phẩm"),
                )
              ],
            ),
          ),
          const Divider(),
          ListView.builder(
            padding: const EdgeInsets.only(bottom: 10),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listSellingProducts.length,
            itemBuilder: (context, index) {
              return Slidable(
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  extentRatio: 0.15,
                  children: [
                    SlidableAction(
                      onPressed: (context) {},
                      // backgroundColor: const Color.fromRGBO(231, 231, 231, 1),
                      foregroundColor: const Color.fromRGBO(177, 40, 48, 1),
                      icon: FontAwesomeIcons.trash,
                      // borderRadius: BorderRadius.circular(15),
                    ),
                  ],
                ),
                child: ItemProduct(index: index),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ItemProduct extends StatefulWidget {
  const ItemProduct({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  State<ItemProduct> createState() => _ItemProductState();
}

class _ItemProductState extends State<ItemProduct> {
  int number = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.index != 0) const Divider(indent: 10, endIndent: 10),
          Row(
            children: [
              Image.asset("assets/tea.png", height: 50, width: 50),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      listSellingProducts[widget.index]["name"]!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Text(listSellingProducts[widget.index]["price"]!),
                  ],
                ),
              ),
              Container(
                color: const Color.fromRGBO(241, 241, 241, 1),
                child: Row(
                  children: [
                    customButtonQuantity(() {
                      setState(() => number++);
                    }, Icons.remove),
                    const SizedBox(width: 10),
                    Text("$number"),
                    const SizedBox(width: 10),
                    customButtonQuantity(() {
                      setState(() => number++);
                    }, Icons.add),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
