import 'package:coffee/src/presentation/product/widgets/body_product.dart';
import 'package:coffee/src/presentation/product/widgets/bottom_widget.dart';
import 'package:flutter/material.dart';

import '../../../data/data_app.dart';
import '../widgets/app_bar_product.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  TextEditingController noteController = TextEditingController();
  final _controller = ScrollController();
  int sizeIndex = 0;
  bool isTop = true;
  int number = 1;

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
            AppBarProduct(isTop: isTop),
            SliverToBoxAdapter(
              child: Image.asset(
                listSellingProducts[widget.index]["image"]!,
                height: 300,
                width: 300,
              ),
            ),
            BodyProduct(
              isTop: isTop,
              sizeIndex: sizeIndex,
              controller: noteController,
              onChange: (value) => setState(() => sizeIndex = value),
            )
          ],
        ),
      ),
      bottomSheet: BottomWidget(
        number: number,
        onChange: (value) => setState(() => number = value),
      ),
    );
  }
}
