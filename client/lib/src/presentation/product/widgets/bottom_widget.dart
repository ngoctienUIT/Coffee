import 'package:coffee/src/core/utils/extensions/int_extension.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/constants/constants.dart';
import 'choose_quantity.dart';

class BottomWidget extends StatelessWidget {
  const BottomWidget({Key? key, required this.number, required this.onChange})
      : super(key: key);

  final int number;
  final Function(int value) onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 75,
      child: Row(
        children: [
          chooseQuantity(number, onChange),
          const SizedBox(width: 20),
          Expanded(
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.statusBarColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(90),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "${"add".translate(context)} ${(number * 30000).toCurrency()}",
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
