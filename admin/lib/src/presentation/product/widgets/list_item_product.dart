import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../controls/function/route_function.dart';
import '../../../data/data_app.dart';
import '../../view_product/screen/view_product_page.dart';

class ListItemProduct extends StatelessWidget {
  const ListItemProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: ListView.builder(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        itemCount: listSellingProducts.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(createRoute(
                screen: ViewProductPage(index: index),
                begin: const Offset(0, 1),
              ));
            },
            child: Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                extentRatio: 0.2,
                children: [
                  SlidableAction(
                    onPressed: (context) {},
                    backgroundColor: const Color.fromRGBO(177, 40, 48, 1),
                    foregroundColor: const Color.fromRGBO(231, 231, 231, 1),
                    icon: FontAwesomeIcons.trash,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ],
              ),
              child: itemOrder(index),
            ),
          );
        },
      ),
    );
  }

  Widget itemOrder(int index) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Row(
          children: [
            Image.asset(
              listSellingProducts[index]["image"]!,
              height: 100,
              width: 100,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listSellingProducts[index]["name"]!,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    listSellingProducts[index]["content"]!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 70,
              child: Text(
                listSellingProducts[index]["price"]!,
                style: const TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
