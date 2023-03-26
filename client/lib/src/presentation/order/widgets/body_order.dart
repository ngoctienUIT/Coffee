import 'package:coffee/src/presentation/order/widgets/grid_item_order.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/constants/app_strings.dart';
import '../../home/widgets/description_line.dart';
import 'list_item_order.dart';

class BodyOrderPage extends StatefulWidget {
  const BodyOrderPage({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<BodyOrderPage> createState() => _BodyOrderPageState();
}

class _BodyOrderPageState extends State<BodyOrderPage> {
  bool check = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              descriptionLine(
                text: listItemProduct[widget.index]["name"]!.toUpperCase(),
              ),
              const Spacer(),
              InkWell(
                onTap: () => setState(() => check = true),
                child: Icon(
                  Icons.menu,
                  color: check ? Colors.red : Colors.grey,
                  size: 35,
                ),
              ),
              InkWell(
                onTap: () => setState(() => check = false),
                child: Icon(
                  Icons.grid_view_rounded,
                  color: check ? Colors.grey : Colors.red,
                  size: 35,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: check ? const ListItemOrder() : gridItemOrder(),
          ),
        ),
      ],
    );
  }
}
