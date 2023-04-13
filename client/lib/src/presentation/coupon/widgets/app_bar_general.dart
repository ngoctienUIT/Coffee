import 'package:flutter/material.dart';

class AppBarGeneral extends StatelessWidget implements PreferredSizeWidget {
  const AppBarGeneral({
    Key? key,
    this.elevation,
    this.title,
    this.icon = Icons.arrow_back_ios_new_rounded,
    this.backgroundColor = Colors.white,
    this.onBack,
    this.action,
    this.onAction,
  }) : super(key: key);

  final String? title;
  final String? action;
  final double? elevation;
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback? onBack;
  final VoidCallback? onAction;

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
        onPressed: () {
          if (onBack != null) onBack!();
          Navigator.pop(context);
        },
      ),
      actions: [
        if (action != null)
          TextButton(onPressed: onAction, child: Text(action!))
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
