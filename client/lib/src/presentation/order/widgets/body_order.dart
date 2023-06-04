import 'package:coffee/src/presentation/order/bloc/order_bloc.dart';
import 'package:coffee/src/presentation/order/bloc/order_event.dart';
import 'package:coffee/src/presentation/order/bloc/order_state.dart';
import 'package:coffee/src/presentation/order/widgets/grid_item_order.dart';
import 'package:coffee/src/presentation/order/widgets/list_product_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../domain/repositories/product/product_response.dart';
import '../../../domain/repositories/product_catalogues/product_catalogues_response.dart';
import '../../home/widgets/description_line.dart';
import 'list_item_order.dart';

class BodyOrderPage extends StatefulWidget {
  const BodyOrderPage({Key? key}) : super(key: key);

  @override
  State<BodyOrderPage> createState() => _BodyOrderPageState();
}

class _BodyOrderPageState extends State<BodyOrderPage> {
  bool check = true;

  @override
  Widget build(BuildContext context) {
    return Column(children: [header(), const SizedBox(height: 10), body()]);
  }

  Widget header() {
    return BlocBuilder<OrderBloc, OrderState>(
      buildWhen: (previous, current) =>
          current is OrderLoading ||
          current is OrderLoaded ||
          current is RefreshOrderLoaded ||
          current is RefreshOrderLoading,
      builder: (context, state) {
        int index = 0;
        List<ProductCataloguesResponse> list =
            context.read<OrderBloc>().listProductCatalogues;
        if (state is RefreshOrderLoading) {
          index = state.index;
        }
        if (state is RefreshOrderLoaded) {
          index = state.index;
        }
        if (state is OrderLoaded) {
          index = state.index;
        }
        if (list.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                descriptionLine(text: list[index].name.toUpperCase()),
                const Spacer(),
                InkWell(
                  onTap: () => setState(() => check = true),
                  child: Icon(
                    Icons.menu,
                    color: check ? Colors.red : Colors.grey,
                    size: 35,
                  ),
                ),
                InkWell(
                  onTap: () => setState(() => check = false),
                  child: Icon(
                    Icons.grid_view_rounded,
                    color: check ? Colors.grey : Colors.red,
                    size: 35,
                  ),
                ),
              ],
            ),
          );
        }
        return _buildLoadingHeader();
      },
    );
  }

  Widget body() {
    return BlocBuilder<OrderBloc, OrderState>(
      buildWhen: (previous, current) => current is! OrderError,
      builder: (context, state) {
        print(state);
        if (state is OrderLoaded || state is RefreshOrderLoaded) {
          List<ProductResponse> listProduct = state is OrderLoaded
              ? state.listProduct
              : (state as RefreshOrderLoaded).listProduct;
          int index = state is OrderLoaded
              ? state.index
              : (state as RefreshOrderLoaded).index;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<OrderBloc>().add(RefreshData(index));
                },
                child: check
                    ? ListItemOrder(listProduct: listProduct)
                    : GridItemOrder(listProduct: listProduct),
              ),
            ),
          );
        }
        return Expanded(child: listProductLoading());
      },
    );
  }

  Widget _buildLoadingHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 40,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          const Spacer(),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: const Icon(Icons.menu, color: Colors.grey, size: 35),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: const Icon(
              Icons.grid_view_rounded,
              color: Colors.grey,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }
}
