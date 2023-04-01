import 'package:flutter/material.dart';

import '../../../core/utils/constants/constants.dart';

class AppBarProduct extends StatelessWidget {
  const AppBarProduct({
    Key? key,
    required this.isTop,
    required this.name,
    required this.onEdit,
  }) : super(key: key);

  final bool isTop;
  final String name;

  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: isTop ? Colors.transparent : AppColors.statusBarColor,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.close,
          color: isTop ? Colors.black : Colors.white,
          size: 30,
        ),
      ),
      actions: [
        IconButton(
          onPressed: onEdit,
          icon: Icon(
            Icons.edit,
            color: isTop ? AppColors.statusBarColor : Colors.white,
          ),
        ),
      ],
      expandedHeight: 0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: AnimatedOpacity(
          opacity: isTop ? 0.0 : 1.0,
          duration: const Duration(milliseconds: 300),
          child: Text(
            name,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        centerTitle: true,
        expandedTitleScale: 1.2,
      ),
    );
  }
}
