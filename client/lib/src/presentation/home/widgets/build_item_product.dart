import 'package:coffee/src/presentation/home/bloc/home_bloc.dart';
import 'package:coffee/src/presentation/list_products_category/screen/list_products_category_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../domain/repositories/product_catalogues/product_catalogues_response.dart';
import '../bloc/home_state.dart';

class BuildListItemProduct extends StatelessWidget {
  const BuildListItemProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is InitState || state is HomeLoading) {
          return _buildLoading();
        }
        if (state is HomeError) {
          return Center(child: Text(state.message!));
        }
        if (state is HomeLoaded) {
          return Container(
            color: Colors.white,
            height: 150,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: state.listProductCatalogues.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(createRoute(
                      screen: ListProductsCategoryPage(index: index),
                      begin: const Offset(0, 1),
                    ));
                  },
                  child: buildItemProduct(state.listProductCatalogues[index]),
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

  Widget buildItemProduct(ProductCataloguesResponse productCatalogues) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: 80,
      child: Column(
        children: [
          Image.asset(AppImages.imgLogo, height: 70),
          const SizedBox(height: 5),
          Text(
            productCatalogues.name.toUpperCase(),
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: AppColors.textColor),
          ),
        ],
      ),
    );
  }
}
