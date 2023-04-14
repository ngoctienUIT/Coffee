import 'dart:math';

import 'package:flutter/material.dart';

import '../../order/widgets/item_loading.dart';

Widget listAccountLoading() {
  var rng = Random();
  return ListView.builder(
    physics: const BouncingScrollPhysics(),
    padding: const EdgeInsets.symmetric(horizontal: 10),
    itemCount: 10,
    itemBuilder: (context, index) {
      return Card(
        child: Row(
          children: [
            const SizedBox(width: 15),
            itemLoading(100, 100, 90),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  itemLoading(20, rng.nextDouble() * 50 + 100, 10),
                  const SizedBox(height: 10),
                  itemLoading(15, rng.nextDouble() * 100 + 100, 10),
                  const SizedBox(height: 10),
                  itemLoading(15, rng.nextDouble() * 150 + 100, 10),
                  const SizedBox(height: 10),
                  itemLoading(20, 100, 10),
                  const SizedBox(height: 10),
                ],
              ),
            )
          ],
        ),
      );
    },
  );
}
