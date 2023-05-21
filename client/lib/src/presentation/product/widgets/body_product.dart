import 'package:coffee/src/core/services/bloc/service_bloc.dart';
import 'package:coffee/src/core/services/bloc/service_event.dart';
import 'package:coffee/src/core/utils/extensions/int_extension.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/data/models/product.dart';
import 'package:coffee/src/presentation/product/bloc/product_bloc.dart';
import 'package:coffee/src/presentation/product/bloc/product_event.dart';
import 'package:coffee/src/presentation/product/bloc/product_state.dart';
import 'package:coffee/src/presentation/product/widgets/product_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/function/loading_animation.dart';
import '../../../core/utils/constants/constants.dart';
import 'choose_size.dart';

class BodyProduct extends StatelessWidget {
  const BodyProduct({Key? key, required this.isTop}) : super(key: key);

  final bool isTop;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        print(state);
        if (state is AddProductToOrderSuccessState ||
            state is UpdateSuccessState ||
            state is DeleteSuccessState) {
          context.read<ServiceBloc>().add(ChangeOrderEvent(
              state.order != null ? state.order!.copyWith() : null));
          if (state is AddProductToOrderSuccessState) {
            customToast(
                context, "product_added_cart_successfully".translate(context));
          }
          Navigator.pop(context);
          Navigator.pop(context);
        }

        if (state is ProductLoadingState) {
          loadingAnimation(context);
        }

        if (state is ProductErrorState) {
          customToast(context, state.error);
        }
      },
      child: view(context),
    );
  }

  Widget view(BuildContext context) {
    return SliverToBoxAdapter(
      child: AnimatedContainer(
        height: MediaQuery.of(context).size.height - 90,
        decoration: BoxDecoration(
          borderRadius: isTop
              ? const BorderRadius.vertical(top: Radius.circular(20))
              : null,
          color: AppColors.bgColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        duration: const Duration(milliseconds: 300),
        child: Column(
          children: [
            const ProductDescription(),
            const SizedBox(height: 20),
            sizeProduct(),
            const SizedBox(height: 20),
            addTopping(),
          ],
        ),
      ),
    );
  }

  Widget addTopping() {
    return BlocBuilder<ProductBloc, ProductState>(
      buildWhen: (previous, current) => current is DataTransmissionState,
      builder: (context, state) {
        Product product = context.read<ProductBloc>().product.copyWith();
        if (product.toppingOptions != null &&
            product.toppingOptions!.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              Text(
                "add".translate(context),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: product.toppingOptions!.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Checkbox(
                        value: product.chooseTopping![index],
                        onChanged: (value) {
                          product.chooseTopping![index] = value!;
                          print(product.chooseTopping);
                          context.read<ProductBloc>().add(DataTransmissionEvent(
                              product: product.copyWith()));
                        },
                      ),
                      Text(product.toppingOptions![index].toppingName),
                      const Spacer(),
                      Text(product.toppingOptions![index].pricePerService
                          .toCurrency()),
                      const SizedBox(width: 10),
                    ],
                  );
                },
              )
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget sizeProduct() {
    return BlocBuilder<ProductBloc, ProductState>(
      buildWhen: (previous, current) => current is DataTransmissionState,
      builder: (context, state) {
        Product product = context.read<ProductBloc>().product.copyWith();
        return Row(
          children: [
            chooseSize(
              text: "S",
              check: product.sizeIndex == 0,
              onPress: () {
                context.read<ProductBloc>().add(DataTransmissionEvent(
                    product: product.copyWith(sizeIndex: 0)));
              },
            ),
            const SizedBox(width: 10),
            chooseSize(
              text: "M",
              check: product.sizeIndex == 1,
              onPress: () {
                context.read<ProductBloc>().add(DataTransmissionEvent(
                    product: product.copyWith(sizeIndex: 1)));
              },
            ),
            const SizedBox(width: 10),
            chooseSize(
              text: "L",
              check: product.sizeIndex == 2,
              onPress: () {
                context.read<ProductBloc>().add(DataTransmissionEvent(
                    product: product.copyWith(sizeIndex: 2)));
              },
            ),
          ],
        );
      },
    );
  }
}
