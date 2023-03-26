import 'package:coffee/src/core/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/constants/app_strings.dart';

class AppBarProduct extends StatelessWidget {
  const AppBarProduct({Key? key, required this.isTop}) : super(key: key);

  final bool isTop;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: isTop ? Colors.transparent : AppColors.statusBarColor,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.close, color: isTop ? Colors.black : Colors.white),
      ),
      expandedHeight: 0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: AnimatedOpacity(
          opacity: isTop ? 0.0 : 1.0,
          duration: const Duration(milliseconds: 300),
          child: Text(
            listSellingProducts[0]["name"]!,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        centerTitle: true,
        expandedTitleScale: 1.2,
      ),
    );
  }
}
