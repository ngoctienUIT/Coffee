import 'package:coffee_admin/src/domain/repositories/product_catalogues/product_catalogues_response.dart';
import 'package:coffee_admin/src/presentation/add_product_catalogues/screen/add_product_catalogues_page.dart';
import 'package:coffee_admin/src/presentation/product_catalogues/bloc/product_catalogues_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../forgot_password/widgets/app_bar_general.dart';
import '../bloc/product_catalogues_event.dart';
import '../bloc/product_catalogues_state.dart';

class ProductCataloguesPage extends StatelessWidget {
  const ProductCataloguesPage({Key? key, this.onPick}) : super(key: key);

  final Function(ProductCataloguesResponse catalogue)? onPick;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCataloguesBloc()..add(FetchData()),
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: const AppBarGeneral(title: "Loại sản phẩm", elevation: 0),
        body: ProductCataloguesView(onPick: onPick),
        floatingActionButton:
            BlocBuilder<ProductCataloguesBloc, ProductCataloguesState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(createRoute(
                  screen: AddProductCataloguesPage(
                    onChange: () {
                      context.read<ProductCataloguesBloc>().add(FetchData());
                    },
                  ),
                  begin: const Offset(0, 1),
                ));
              },
              backgroundColor: AppColors.statusBarColor,
              child: const Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }
}

class ProductCataloguesView extends StatelessWidget {
  const ProductCataloguesView({Key? key, this.onPick}) : super(key: key);

  final Function(ProductCataloguesResponse catalogue)? onPick;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCataloguesBloc, ProductCataloguesState>(
      builder: (context, state) {
        if (state is InitState || state is ProductCataloguesLoading) {
          return _buildLoading();
        }
        if (state is ProductCataloguesError) {
          return Center(child: Text(state.message!));
        }
        if (state is ProductCataloguesLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<ProductCataloguesBloc>().add(FetchData());
            },
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: const EdgeInsets.all(10),
              itemCount: state.listProductCatalogues.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: InkWell(
                    onTap: onPick != null
                        ? () {
                            onPick!(state.listProductCatalogues[index]);
                            Navigator.pop(context);
                          }
                        : null,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Image.network(
                            state.listProductCatalogues[index].image,
                            height: 80,
                            width: 80,
                          ),
                          Text(
                            state.listProductCatalogues[index].name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppColors.statusBarColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
