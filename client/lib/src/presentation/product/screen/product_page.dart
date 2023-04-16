import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee/src/presentation/product/bloc/product_bloc.dart';
import 'package:coffee/src/presentation/product/bloc/product_event.dart';
import 'package:coffee/src/presentation/product/widgets/body_product.dart';
import 'package:coffee/src/presentation/product/widgets/bottom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/product.dart';
import '../../store/widgets/item_loading.dart';
import '../widgets/app_bar_product.dart';

class ProductPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductBloc()..add(DataTransmissionEvent(product: product)),
      child: ProductView(
          product: product, isEdit: isEdit, onPress: onPress, index: index),
    );
  }
}

class ProductView extends StatefulWidget {
  const ProductView({
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
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  final _controller = ScrollController();
  bool isTop = true;

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
            AppBarProduct(isTop: isTop, name: widget.product.name),
            SliverToBoxAdapter(
              child: CachedNetworkImage(
                height: 300,
                width: 300,
                imageUrl: widget.product.image!,
                placeholder: (context, url) => itemLoading(300, 300, 0),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            BodyProduct(isTop: isTop, onPress: widget.onPress)
          ],
        ),
      ),
      bottomSheet: BottomWidget(isEdit: widget.isEdit, index: widget.index),
    );
  }
}
