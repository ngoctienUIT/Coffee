import 'package:coffee/src/presentation/product/bloc/product_bloc.dart';
import 'package:coffee/src/presentation/product/bloc/product_event.dart';
import 'package:coffee/src/presentation/product/bloc/product_state.dart';
import 'package:coffee/src/presentation/product/widgets/body_product.dart';
import 'package:coffee/src/presentation/product/widgets/bottom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/product.dart';
import '../widgets/app_bar_product.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({
    Key? key,
    this.index,
    required this.product,
    required this.isEdit,
    this.onPress,
  }) : super(key: key);

  final Product product;
  final bool isEdit;
  final int? index;
  final VoidCallback? onPress;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
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
      create: (context) =>
          ProductBloc()..add(DataTransmissionEvent(product: widget.product)),
      child: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is AddProductToOrderSuccessState ||
              state is UpdateSuccessState ||
              state is DeleteSuccessState) {
            widget.onPress!();
            Navigator.pop(context);
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: CustomScrollView(
              // physics: const BouncingScrollPhysics(),
              controller: _controller,
              slivers: [
                AppBarProduct(isTop: isTop, name: widget.product.name),
                SliverToBoxAdapter(
                  child: Image.network(
                    widget.product.image!,
                    height: 300,
                    width: 300,
                  ),
                ),
                BodyProduct(isTop: isTop)
              ],
            ),
          ),
          bottomSheet: BottomWidget(isEdit: widget.isEdit, index: widget.index),
        ),
      ),
    );
  }
}
