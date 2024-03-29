import 'package:coffee_admin/src/core/utils/extensions/int_extension.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/constants/constants.dart';
import '../bloc/view_product_bloc.dart';
import '../bloc/view_product_event.dart';
import '../bloc/view_product_state.dart';
import 'choose_size.dart';
import 'product_description.dart';

class BodyProduct extends StatelessWidget {
  const BodyProduct({Key? key, required this.isTop}) : super(key: key);

  final bool isTop;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: AnimatedContainer(
        height: MediaQuery.of(context).size.height - 80,
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
    return BlocBuilder<ViewProductBloc, ViewProductState>(
      builder: (context, state) {
        if (state is DataTransmissionState &&
            state.product.toppingOptions!.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              Text(
                AppLocalizations.of(context)!.add,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.product.toppingOptions!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Text(state.product.toppingOptions![index].toppingName),
                        const Spacer(),
                        Text(state
                            .product.toppingOptions![index].pricePerService
                            .toCurrency()),
                        const SizedBox(width: 10),
                      ],
                    ),
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
    return BlocBuilder<ViewProductBloc, ViewProductState>(
      builder: (context, state) {
        if (state is DataTransmissionState) {
          return Row(
            children: [
              chooseSize(
                text: "S",
                check: state.product.sizeIndex == 0,
                onPress: () {
                  context.read<ViewProductBloc>().add(DataTransmissionEvent(
                      product: state.product.copyWith(sizeIndex: 0)));
                },
              ),
              const SizedBox(width: 10),
              chooseSize(
                text: "M",
                check: state.product.sizeIndex == 1,
                onPress: () {
                  context.read<ViewProductBloc>().add(DataTransmissionEvent(
                      product: state.product.copyWith(sizeIndex: 1)));
                },
              ),
              const SizedBox(width: 10),
              chooseSize(
                text: "L",
                check: state.product.sizeIndex == 2,
                onPress: () {
                  context.read<ViewProductBloc>().add(DataTransmissionEvent(
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
