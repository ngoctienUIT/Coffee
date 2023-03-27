import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/app_strings.dart';
import '../../../domain/repositories/product/product_response.dart';
import '../../product/screen/product_page.dart';
import '../bloc/order_bloc.dart';
import '../bloc/order_event.dart';

class GridItemOrder extends StatelessWidget {
  const GridItemOrder({Key? key, required this.listProduct}) : super(key: key);

  final List<ProductResponse> listProduct;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<OrderBloc>(context).add(FetchData());
      },
      child: GridView.builder(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: listProduct.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(createRoute(
                screen: ProductPage(index: index),
                begin: const Offset(0, 1),
              ));
            },
            child: itemOrder(index),
          );
        },
      ),
    );
  }

  Widget itemOrder(int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                listSellingProducts[index % 7]["image"]!,
                width: 80,
              ),
            ),
            const Spacer(),
            Text(
              listProduct[index].name,
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              "${listProduct[index].price}${listProduct[index].currency}",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
