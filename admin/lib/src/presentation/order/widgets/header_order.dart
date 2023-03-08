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
        tabs: const [
          Tab(text: "Tất cả"),
          Tab(text: "Chưa giao"),
          Tab(text: "Đang giao"),
          Tab(text: "Đã giao"),
          Tab(text: "Đã hủy"),
        ],
      ),
    );
  }
}
