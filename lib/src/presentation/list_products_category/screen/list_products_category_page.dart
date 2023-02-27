import 'package:coffee/src/presentation/order/widgets/bottom_sheet_order.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../data/data_app.dart';
import '../../order/widgets/grid_item_order.dart';
import '../../order/widgets/list_item_order.dart';

class ListProductsCategoryPage extends StatefulWidget {
  const ListProductsCategoryPage({Key? key, required this.index})
      : super(key: key);
  final int index;

  @override
  State<ListProductsCategoryPage> createState() =>
      _ListProductsCategoryPageState();
}

class _ListProductsCategoryPageState extends State<ListProductsCategoryPage> {
  bool check = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          listItemProduct[widget.index]["name"]!,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              FontAwesomeIcons.magnifyingGlass,
              color: Colors.grey,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                const Spacer(),
                InkWell(
                  onTap: () {
                    setState(() => check = true);
                  },
                  child: Icon(
                    Icons.menu,
                    color: check ? Colors.red : Colors.grey,
                    size: 35,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() => check = false);
                  },
                  child: Icon(
                    Icons.grid_view_rounded,
                    color: check ? Colors.grey : Colors.red,
                    size: 35,
                  ),
                ),
              ],
            ),
            Expanded(child: check ? const ListItemOrder() : gridItemOrder()),
          ],
        ),
      ),
      bottomSheet: const BottomSheetOrder(),
    );
  }
}
