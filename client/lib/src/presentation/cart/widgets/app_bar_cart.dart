import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/constants/constants.dart';

class AppBarCart extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCart({Key? key, required this.clearCart}) : super(key: key);

  final VoidCallback clearCart;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.bgColor,
      elevation: 0,
      title: Text(
        "cart".translate(context),
        style: const TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.black,
        ),
      ),
      actions: [
        TextButton(
          onPressed: clearCart,
          child: Text("clear_cart".translate(context)),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
