import 'dart:math';

import 'package:coffee_admin/src/core/utils/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../order/widgets/item_loading.dart';

Widget productItemLoading(double height) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Image.asset(AppImages.imgProductLoading, height: height),
  );
}

Widget listProductLoading() {
  var rng = Random();
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Card(
            child: Row(
              children: [
                productItemLoading(100),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      itemLoading(20, rng.nextDouble() * 50 + 100, 10),
                      const SizedBox(height: 10),
                      itemLoading(15, double.infinity, 10),
                      const SizedBox(height: 10),
                      itemLoading(15, rng.nextDouble() * 50 + 150, 10),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                itemLoading(30, 100, 10),
                const SizedBox(width: 10),
              ],
            ),
          ),
        );
      },
    ),
  );
}
