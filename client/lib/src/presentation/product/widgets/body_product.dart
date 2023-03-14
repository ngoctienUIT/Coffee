import 'package:coffee/src/controls/extension/string_extension.dart';
import 'package:coffee/src/presentation/product/widgets/product_description.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../signup/widgets/custom_text_input.dart';
import 'choose_size.dart';

class BodyProduct extends StatelessWidget {
  const BodyProduct({
    Key? key,
    required this.controller,
    required this.isTop,
    required this.sizeIndex,
    required this.onChange,
  }) : super(key: key);

  final TextEditingController controller;
  final bool isTop;
  final int sizeIndex;
  final Function(int value) onChange;

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
            const ProductDescription(),
            const SizedBox(height: 20),
            Row(
              children: [
                chooseSize("S", sizeIndex == 0, () => onChange(0)),
                const SizedBox(width: 10),
                chooseSize("M", sizeIndex == 1, () => onChange(1)),
                const SizedBox(width: 10),
                chooseSize("L", sizeIndex == 2, () => onChange(2)),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(color: Colors.black),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(FontAwesomeIcons.fileLines),
                const SizedBox(width: 5),
                Text(
                  "note".translate(context),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 5),
                Text("optional".translate(context)),
              ],
            ),
            const SizedBox(height: 15),
            CustomTextInput(
              controller: controller,
              hint: "note".translate(context),
              colorBorder: Colors.black87,
            ),
          ],
        ),
      ),
    );
  }
}
