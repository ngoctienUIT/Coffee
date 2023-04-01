import 'package:coffee_admin/src/domain/repositories/product/product_response.dart';
import 'package:coffee_admin/src/presentation/view_product/widgets/app_bar_product.dart';
import 'package:coffee_admin/src/presentation/view_product/widgets/body_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/route_function.dart';
import '../../../data/models/product.dart';
import '../../add_product/screen/add_product_page.dart';
import '../bloc/view_product_bloc.dart';
import '../bloc/view_product_event.dart';

class ViewProductPage extends StatefulWidget {
  const ViewProductPage({Key? key, required this.product}) : super(key: key);
  final ProductResponse product;

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
    return BlocProvider(
      create: (context) => ViewProductBloc()
        ..add(DataTransmissionEvent(
            product: Product.fromProductResponse(widget.product))),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: CustomScrollView(
            // physics: const BouncingScrollPhysics(),
            controller: _controller,
            slivers: [
              AppBarProduct(
                isTop: isTop,
                name: widget.product.name,
                onEdit: () {
                  Navigator.of(context).push(createRoute(
                    screen: const AddProductPage(),
                    begin: const Offset(0, 1),
                  ));
                },
              ),
              SliverToBoxAdapter(
                child: Image.network(
                  widget.product.image!,
                  height: 300,
                  width: 300,
                ),
              ),
              BodyProduct(isTop: isTop),
            ],
          ),
        ),
      ),
    );
  }
}
