import 'package:coffee_admin/src/presentation/add_product/screen/add_product_page.dart';
import 'package:flutter/material.dart';

import '../../../controls/route_function.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
