import 'package:coffee/src/presentation/list_products_category/screen/list_products_category_page.dart';
import 'package:flutter/material.dart';

import '../../../data/data_app.dart';

Widget buildListItemProduct() {
  return Container(
    color: Colors.white,
    height: 150,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: listItemProduct.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListProductsCategoryPage(index: index),
                ));
          },
          child: buildItemProduct(index),
        );
      },
    ),
  );
}

Widget buildItemProduct(int index) {
  return Container(
    margin: const EdgeInsets.all(10),
    width: 80,
    child: Column(
      children: [
        Image.asset(listItemProduct[index]["image"]!, height: 70),
        const SizedBox(height: 5),
        Text(
          listItemProduct[index]["name"]!,
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
