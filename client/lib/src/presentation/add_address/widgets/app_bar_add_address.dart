import 'package:coffee/src/controls/extension/string_extension.dart';
import 'package:flutter/material.dart';

class AppBarAddAddress extends StatelessWidget implements PreferredSizeWidget {
  const AppBarAddAddress({Key? key, required this.delete}) : super(key: key);

  final VoidCallback delete;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
      elevation: 1,
      title: Text(
        "edit_address".translate(context),
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
        IconButton(
          onPressed: delete,
          icon: const Icon(Icons.delete, color: Colors.black),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
