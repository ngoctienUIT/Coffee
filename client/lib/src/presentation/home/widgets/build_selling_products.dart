import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee/src/core/utils/extensions/int_extension.dart';
import 'package:coffee/src/data/models/product.dart';
import 'package:coffee/src/presentation/order/widgets/list_product_loading.dart';
import 'package:coffee/src/presentation/store/widgets/item_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/route_function.dart';
import '../../../domain/repositories/product/product_response.dart';
import '../../product/screen/product_page.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';

class BuildListSellingProducts extends StatelessWidget {
  const BuildListSellingProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          current is! ChangeBannerState &&
          current is! CouponLoaded &&
          current is! CartLoaded &&
          current is! HomeError,
      builder: (context, state) {
        if (state is HomeLoaded) {
          return SizedBox(
            height: 250,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: state.address != null ? state.listProduct.length : 15,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(5),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(createRoute(
                        screen: ProductPage(
                          // onPress: () {
                          //   context.read<HomeBloc>().add(AddProductToCart());
                          // },
                          isEdit: false,
                          product: Product.fromProductResponse(
                              state.listProduct[index]),
                        ),
                        begin: const Offset(0, 1),
                      ));
                    },
                    child: buildSellingProducts(state.listProduct[index]),
                  ),
                );
              },
            ),
          );
        }
        return _buildLoading();
      },
    );
  }

  Widget _buildLoading() {
    Random rng = Random();
    return SizedBox(
      height: 250,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            child: SizedBox(
              width: 150,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    itemProductLoading(120),
                    const Spacer(),
                    itemLoading(15, rng.nextDouble() * 50 + 80, 10),
                    const SizedBox(height: 10),
                    itemLoading(25, rng.nextDouble() * 50 + 80, 10),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSellingProducts(ProductResponse product) {
    return Card(
      child: SizedBox(
        width: 150,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              CachedNetworkImage(
                height: 120,
                width: 120,
                imageUrl: product.image ?? "",
                placeholder: (context, url) => itemProductLoading(120),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const Spacer(),
              Text(
                product.name,
                maxLines: 2,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(241, 233, 222, 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  product.price.toCurrency(),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
