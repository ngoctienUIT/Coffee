import 'package:flutter/material.dart';

import '../../../data/data_app.dart';

class BodyProduct extends StatelessWidget {
  const BodyProduct({Key? key, required this.isTop}) : super(key: key);

  final bool isTop;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: AnimatedContainer(
        height: MediaQuery.of(context).size.height - 90,
        decoration: BoxDecoration(
          borderRadius: isTop
              ? const BorderRadius.vertical(top: Radius.circular(20))
              : null,
          color: const Color.fromRGBO(241, 241, 241, 1),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        duration: const Duration(milliseconds: 300),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  listSellingProducts[0]["name"]!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  listSellingProducts[0]["price"]!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(listSellingProducts[0]["content"]!),
          ],
        ),
      ),
    );
  }
}
