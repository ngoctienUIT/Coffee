import 'dart:math';

import 'package:flutter/material.dart';

import 'item_loading.dart';

Widget listOrderLoading() {
  return ListView.builder(
    physics: const BouncingScrollPhysics(),
    padding: const EdgeInsets.symmetric(horizontal: 10),
    itemCount: 10,
    itemBuilder: (context, index) {
      return itemOrderLoading();
    },
  );
}

Widget itemOrderLoading() {
  var rng = Random();
  bool check = rng.nextBool();
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              itemLoading(40, 40, 0),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    itemLoading(
                        20,
                        check ? double.infinity : rng.nextDouble() * 150 + 100,
                        10),
                    const SizedBox(height: 5),
                    if (check) itemLoading(20, rng.nextDouble() * 100 + 50, 10),
                  ],
                ),
              )
            ],
          ),
          const Divider(),
          Row(
            children: [
              Column(
                children: [
                  itemLoading(100, 100, 90),
                  const SizedBox(height: 10),
                  itemLoading(20, 100, 10)
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: itemLoading(20, rng.nextDouble() * 100 + 100, 90),
                    ),
                    const SizedBox(height: 10),
                    itemLoading(15, rng.nextDouble() * 100 + 100, 10),
                    const SizedBox(height: 10),
                    itemLoading(15, rng.nextDouble() * 100 + 100, 10),
                    const SizedBox(height: 10),
                    itemLoading(15, rng.nextDouble() * 100 + 100, 10),
                    const SizedBox(height: 10),
                    itemLoading(15, rng.nextDouble() * 100 + 100, 10),
                  ],
                ),
              )
            ],
          ),
          const Divider(),
          Row(
            children: [
              itemLoading(15, 150, 10),
              const Spacer(),
              itemLoading(20, 100, 10),
            ],
          )
        ],
      ),
    ),
  );
}
