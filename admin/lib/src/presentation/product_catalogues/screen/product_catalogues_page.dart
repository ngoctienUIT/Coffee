import 'package:coffee_admin/src/data/models/product_catalogues.dart';
import 'package:coffee_admin/src/domain/repositories/product_catalogues/product_catalogues_response.dart';
import 'package:coffee_admin/src/presentation/add_product_catalogues/screen/add_product_catalogues_page.dart';
import 'package:coffee_admin/src/presentation/product_catalogues/bloc/product_catalogues_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
          final listProductCatalogues = state.listProductCatalogues;
          return RefreshIndicator(
            onRefresh: () async {
              context.read<ProductCataloguesBloc>().add(FetchData());
            },
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 60),
              itemCount: listProductCatalogues.length,
              itemBuilder: (context, index) {
                final myContext = context;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: InkWell(
                    onTap: onPick != null
                        ? () {
                            onPick!(listProductCatalogues[index]);
                            Navigator.pop(context);
                          }
                        : null,
                    child: Slidable(
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        extentRatio: 0.32,
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              Navigator.of(context).push(createRoute(
                                screen: AddProductCataloguesPage(
                                  productCatalogues:
                                      ProductCatalogues.fromResponse(
                                          listProductCatalogues[index]),
                                  onChange: () {
                                    myContext
                                        .read<ProductCataloguesBloc>()
                                        .add(FetchData());
                                  },
                                ),
                                begin: const Offset(0, 1),
                              ));
                            },
                            backgroundColor: AppColors.statusBarColor,
                            foregroundColor:
                                const Color.fromRGBO(231, 231, 231, 1),
                            icon: FontAwesomeIcons.penToSquare,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          SlidableAction(
                            onPressed: (context) {
                              context.read<ProductCataloguesBloc>().add(
                                  DeleteEvent(listProductCatalogues[index].id));
                            },
                            backgroundColor: AppColors.statusBarColor,
                            foregroundColor:
                                const Color.fromRGBO(231, 231, 231, 1),
                            icon: FontAwesomeIcons.trash,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ],
                      ),
                      child:
                          productCataloguesItem(listProductCatalogues[index]),
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

  Widget productCataloguesItem(ProductCataloguesResponse productCatalogues) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Image.network(productCatalogues.image, height: 80, width: 80),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productCatalogues.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.statusBarColor,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  productCatalogues.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
