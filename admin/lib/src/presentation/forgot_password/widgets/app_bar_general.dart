import 'package:flutter/material.dart';

class AppBarGeneral extends StatelessWidget implements PreferredSizeWidget {
  const AppBarGeneral({
    Key? key,
    this.elevation,
    this.title,
    this.icon = Icons.arrow_back_ios_new_rounded,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  final String? title;
  final double? elevation;
  final IconData icon;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      title: title != null
          ? Text(title!, style: const TextStyle(color: Colors.black))
          : null,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(icon),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
