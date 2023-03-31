import 'package:coffee/src/presentation/order/bloc/order_bloc.dart';
import 'package:coffee/src/presentation/order/bloc/order_event.dart';
import 'package:coffee/src/presentation/order/bloc/order_state.dart';
import 'package:coffee/src/presentation/order/widgets/grid_item_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/product/product_response.dart';
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
          current is OrderError,
      builder: (context, state) {
        if (state is InitState || state is OrderLoading) {
          return _buildLoading();
        }
        if (state is OrderError) {
          return Center(child: Text(state.message!));
        }
        if (state is OrderLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                descriptionLine(
                  text: state.listProductCatalogues[state.index].name
                      .toUpperCase(),
                ),
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
        return Container();
      },
    );
  }

  Widget body() {
    return BlocBuilder<OrderBloc, OrderState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        print(state);
        if (state is InitState ||
            state is OrderLoading ||
            state is RefreshOrderLoading) {
          return _buildLoading();
        }
        if (state is OrderError || state is RefreshOrderError) {
          return Center(
            child: Text(state is OrderError
                ? state.message!
                : (state as RefreshOrderError).message!),
          );
        }
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
        return Container();
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
