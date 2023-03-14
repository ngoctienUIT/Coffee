import 'package:flutter/material.dart';

import '../../../data/data_app.dart';

class AppBarProduct extends StatelessWidget {
  const AppBarProduct({Key? key, required this.isTop, required this.onEdit})
      : super(key: key);

  final bool isTop;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor:
          isTop ? Colors.transparent : const Color.fromRGBO(177, 40, 48, 1),
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
            color: isTop ? const Color.fromRGBO(177, 40, 48, 1) : Colors.white,
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
