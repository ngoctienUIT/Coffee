import 'package:flutter/material.dart';

import '../../../data/data_app.dart';
import 'description_line.dart';
import 'list_item_order.dart';

class BodyOrderPage extends StatelessWidget {
  const BodyOrderPage({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              descriptionLine(
                text: listItemProduct[index]["name"]!.toUpperCase(),
              ),
              const Spacer(),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ListItemOrder(),
          ),
        ),
      ],
    );
  }
}
