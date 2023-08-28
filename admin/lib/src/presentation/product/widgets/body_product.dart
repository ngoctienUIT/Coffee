import 'package:coffee_admin/src/core/function/loading_animation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:coffee_admin/src/presentation/product/widgets/list_product_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/function/custom_toast.dart';
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
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is ProductError) {
          customToast(context, state.message.toString());
        }
        if (state is ProductLoading && !state.check) {
          loadingAnimation(context);
        }
        if (state is RefreshLoaded && !state.check) {
          Navigator.pop(context);
          customToast(
              context, AppLocalizations.of(context)!.deleteSuccessfully);
        }
      },
      child: Column(
        children: [header(), const SizedBox(height: 10), body()],
      ),
    );
  }

  Widget header() {
    return BlocBuilder<ProductBloc, ProductState>(
      buildWhen: (previous, current) =>
          current is! RefreshLoading &&
          !(current is ProductLoading && !current.check),
      builder: (context, state) {
        if (state is ProductLoaded || state is RefreshLoaded) {
          int index = state is ProductLoaded
              ? state.index
              : (state as RefreshLoaded).index;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: descriptionLine(
              text: context
                  .read<ProductBloc>()
                  .listProductCatalogues[index]
                  .name
                  .toUpperCase(),
            ),
          );
        }
        return _buildLoadingHeader();
      },
    );
  }

  Widget body() {
    return BlocBuilder<ProductBloc, ProductState>(
      buildWhen: (previous, current) =>
          previous != current && !(current is ProductLoading && !current.check),
      builder: (context, state) {
        print(state);
        if (state is ProductLoaded || state is RefreshLoaded) {
          int index = state is ProductLoaded
              ? state.index
              : (state as RefreshLoaded).index;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<ProductBloc>().add(RefreshData(index));
                },
                child: ListItemProduct(
                  productCatalogues:
                      context.read<ProductBloc>().listProductCatalogues[
                          state is RefreshLoaded ? state.index : 0],
                  onChange: () {
                    int index = 0;
                    if (state is RefreshLoaded) {
                      index = state.index;
                    } else {
                      index = 0;
                    }
                    context.read<ProductBloc>().add(RefreshData(index));
                  },
                  listProduct: state is ProductLoaded
                      ? state.listProduct
                      : (state as RefreshLoaded).listProduct,
                  onDelete: (id) {
                    context.read<ProductBloc>().add(DeleteEvent(index, id));
                  },
                ),
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
      child: Align(
        alignment: Alignment.centerLeft,
        child: Shimmer.fromColors(
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
      ),
    );
  }
}
