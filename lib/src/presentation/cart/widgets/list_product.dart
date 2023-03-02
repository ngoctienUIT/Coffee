import 'package:flutter/material.dart';

import '../../../data/data_app.dart';

Widget listProduct() {
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
              const Text("Danh sách sản phẩm"),
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
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  if (index != 0) const Divider(indent: 10, endIndent: 10),
                  Row(
                    children: [
                      const Text("(1x)"),
                      const SizedBox(width: 5),
                      Text(listSellingProducts[index]["name"]!),
                      const Spacer(),
                      Text(listSellingProducts[index]["price"]!),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    ),
  );
}
