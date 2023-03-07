import 'package:coffee_admin/src/presentation/add_product/screen/add_product_page.dart';
import 'package:flutter/material.dart';

import '../../../controls/function/route_function.dart';
import '../../../data/data_app.dart';
import '../widgets/body_product.dart';
import '../widgets/header_product.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with TickerProviderStateMixin {
  late TabController _productController;

  @override
  void initState() {
    _productController =
        TabController(length: listItemProduct.length, vsync: this);
    _productController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
      body: SafeArea(
        child: Column(
          children: [
            HeaderProductPage(tabController: _productController),
            const SizedBox(height: 20),
            Expanded(child: BodyProductPage(index: _productController.index)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(createRoute(
            screen: const AddProductPage(),
            begin: const Offset(0, 1),
          ));
        },
        backgroundColor: const Color.fromRGBO(177, 40, 48, 1),
        child: const Icon(Icons.add),
      ),
    );
  }
}
