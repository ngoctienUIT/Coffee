import 'package:coffee/src/presentation/product/bloc/product_bloc.dart';
import 'package:coffee/src/presentation/product/bloc/product_event.dart';
import 'package:coffee/src/presentation/product/bloc/product_state.dart';
import 'package:coffee/src/presentation/product/widgets/product_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/constants/constants.dart';
import 'choose_size.dart';

class BodyProduct extends StatelessWidget {
  const BodyProduct({Key? key, required this.isTop}) : super(key: key);

  final bool isTop;

  @override
  Widget build(BuildContext context) {
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
      buildWhen: (previous, current) =>
          current is! AddProductToOrderSuccessState ||
          current is AddProductToOrderErrorState ||
          current is AddProductToOrderLoadingState,
      builder: (context, state) {
        if (state is DataTransmissionState &&
            state.product.toppingOptions!.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              const Text(
                "Thêm",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.product.toppingOptions!.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Checkbox(
                        value: true,
                        onChanged: (value) {},
                      ),
                      Text(state.product.toppingOptions![index].toppingName),
                      const Spacer(),
                      Text(
                          "${state.product.toppingOptions![index].pricePerService}đ"),
                      const SizedBox(width: 10),
                    ],
                  );
                },
              )
            ],
          );
        }
        return Container();
      },
    );
  }

  Widget sizeProduct() {
    return BlocBuilder<ProductBloc, ProductState>(
      buildWhen: (previous, current) =>
          current is! AddProductToOrderSuccessState ||
          current is AddProductToOrderErrorState ||
          current is AddProductToOrderLoadingState,
      builder: (context, state) {
        if (state is DataTransmissionState) {
          return Row(
            children: [
              chooseSize(
                text: "S",
                check: state.product.sizeIndex == 0,
                onPress: () {
                  context.read<ProductBloc>().add(DataTransmissionEvent(
                      product: state.product.copyWith(sizeIndex: 0)));
                },
              ),
              const SizedBox(width: 10),
              chooseSize(
                text: "M",
                check: state.product.sizeIndex == 1,
                onPress: () {
                  context.read<ProductBloc>().add(DataTransmissionEvent(
                      product: state.product.copyWith(sizeIndex: 1)));
                },
              ),
              const SizedBox(width: 10),
              chooseSize(
                text: "L",
                check: state.product.sizeIndex == 2,
                onPress: () {
                  context.read<ProductBloc>().add(DataTransmissionEvent(
                      product: state.product.copyWith(sizeIndex: 2)));
                },
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
