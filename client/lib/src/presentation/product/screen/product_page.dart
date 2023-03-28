import 'package:coffee/src/domain/repositories/product/product_response.dart';
import 'package:coffee/src/presentation/product/bloc/product_bloc.dart';
import 'package:coffee/src/presentation/product/bloc/product_event.dart';
import 'package:coffee/src/presentation/product/widgets/body_product.dart';
import 'package:coffee/src/presentation/product/widgets/bottom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/constants/app_strings.dart';
import '../../../data/models/product.dart';
import '../widgets/app_bar_product.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key, required this.product}) : super(key: key);
  final ProductResponse product;

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
    return BlocProvider(
      create: (context) => ProductBloc()
        ..add(DataTransmissionEvent(
            product: Product.fromProductResponse(widget.product))),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: CustomScrollView(
            // physics: const BouncingScrollPhysics(),
            controller: _controller,
            slivers: [
              AppBarProduct(isTop: isTop, name: widget.product.name),
              SliverToBoxAdapter(
                child: Image.asset(
                  listSellingProducts[0]["image"]!,
                  height: 300,
                  width: 300,
                ),
              ),
              BodyProduct(
                isTop: isTop,
                controller: noteController,
              )
            ],
          ),
        ),
        bottomSheet: const BottomWidget(),
      ),
    );
  }
}
