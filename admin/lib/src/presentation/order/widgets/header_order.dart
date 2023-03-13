import 'package:coffee_admin/src/controls/extension/string_extension.dart';
import 'package:flutter/material.dart';

class HeaderOrderPage extends StatelessWidget {
  const HeaderOrderPage({Key? key, required this.tabController})
      : super(key: key);
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 56,
      child: TabBar(
        controller: tabController,
        physics: const BouncingScrollPhysics(),
        isScrollable: true,
        labelColor: Colors.black87,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelColor: const Color.fromRGBO(45, 216, 198, 1),
        unselectedLabelStyle: const TextStyle(fontSize: 16),
        indicatorColor: Colors.green,
        tabs: [
          Tab(text: "all".translate(context)),
          Tab(text: "not_delivery".translate(context)),
          Tab(text: "delivering".translate(context)),
          Tab(text: "delivered".translate(context)),
          Tab(text: "cancelled".translate(context)),
        ],
      ),
    );
  }
}
