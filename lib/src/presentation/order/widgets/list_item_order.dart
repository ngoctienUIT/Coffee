import 'package:coffee/src/presentation/product/screen/product_page.dart';
import 'package:flutter/material.dart';

import '../../../data/data_app.dart';

class ListItemOrder extends StatelessWidget {
  const ListItemOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listSellingProducts.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductPage(index: index),
                ));
          },
          child: itemOrder(index),
        );
      },
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
            const SizedBox(width: 5),
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
