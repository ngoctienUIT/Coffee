import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import 'description_line.dart';
import 'list_item_product.dart';

class BodyProductPage extends StatefulWidget {
  const BodyProductPage({Key? key}) : super(key: key);

  @override
  State<BodyProductPage> createState() => _BodyProductPageState();
}

class _BodyProductPageState extends State<BodyProductPage> {
  bool check = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [header(), const SizedBox(height: 10), body()],
    );
  }

  Widget header() {
    return BlocBuilder<ProductBloc, ProductState>(
      buildWhen: (previous, current) =>
          current is ProductLoading ||
          current is ProductLoaded ||
          current is ProductError,
      builder: (context, state) {
        if (state is InitState || state is ProductLoading) {
          return _buildLoading();
        }
        if (state is ProductError) {
          return Center(child: Text(state.message!));
        }
        if (state is ProductLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: descriptionLine(
              text: state.listProductCatalogues[state.index].name.toUpperCase(),
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget body() {
    return BlocBuilder<ProductBloc, ProductState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        print(state);

        if (state is InitState ||
            state is ProductLoading ||
            state is RefreshLoading) {
          return _buildLoading();
        }
        if (state is ProductError || state is RefreshError) {
          return Center(
            child: Text(state is ProductError
                ? state.message!
                : (state as RefreshError).message!),
          );
        }
        if (state is ProductLoaded || state is RefreshLoaded) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RefreshIndicator(
                onRefresh: () async {
                  int index = state is ProductLoaded
                      ? state.index
                      : (state as RefreshLoaded).index;
                  context.read<ProductBloc>().add(RefreshData(index));
                },
                child: ListItemProduct(
                    listProduct: state is ProductLoaded
                        ? state.listProduct
                        : (state as RefreshLoaded).listProduct),
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
