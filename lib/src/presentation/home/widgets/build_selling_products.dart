import 'package:flutter/material.dart';

import '../../../data/data_app.dart';

Widget buildListSellingProducts() {
  return SizedBox(
    height: 250,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: listSellingProducts.length,
      itemBuilder: (context, index) {
        return buildSellingProducts(index);
      },
    ),
  );
}

Widget buildSellingProducts(int index) {
  return Container(
    margin: const EdgeInsets.all(5),
    child: InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {},
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: SizedBox(
          width: 150,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Image.asset(
                  listSellingProducts[index]["image"]!,
                  height: 120,
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(listSellingProducts[index]["name"]!, maxLines: 2),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      listSellingProducts[index]["price"]!,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
