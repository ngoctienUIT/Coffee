import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/constants/constants.dart';

class AppBarAddAddress extends StatelessWidget implements PreferredSizeWidget {
  const AppBarAddAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.bgColor,
      elevation: 1,
      title: Text(
        "edit_address".translate(context),
        style: const TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
