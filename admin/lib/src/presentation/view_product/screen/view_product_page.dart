import 'package:coffee_admin/src/presentation/view_product/widgets/app_bar_product.dart';
import 'package:coffee_admin/src/presentation/view_product/widgets/body_product.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/constants/constants.dart';

class ViewProductPage extends StatefulWidget {
  const ViewProductPage({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<ViewProductPage> createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewProductPage> {
  final _controller = ScrollController();
  bool isTop = true;
  int sizeIndex = 0;

  @override
  void initState() {
    _controller.addListener(() {
      setState(() => isTop =
          _controller.position.pixels != _controller.position.maxScrollExtent);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          // physics: const BouncingScrollPhysics(),
          controller: _controller,
          slivers: [
            AppBarProduct(isTop: isTop, onEdit: () {}),
            SliverToBoxAdapter(
              child: Image.asset(
                listSellingProducts[widget.index]["image"]!,
                height: 300,
                width: 300,
              ),
            ),
            BodyProduct(isTop: isTop),
          ],
        ),
      ),
    );
  }
}
