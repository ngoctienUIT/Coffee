import 'package:flutter/material.dart';

import '../../../core/utils/constants/app_strings.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              listSellingProducts[0]["name"]!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Text(
              listSellingProducts[0]["price"]!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(listSellingProducts[0]["content"]!),
      ],
    );
  }
}
