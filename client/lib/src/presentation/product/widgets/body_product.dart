import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/presentation/product/bloc/product_bloc.dart';
import 'package:coffee/src/presentation/product/bloc/product_event.dart';
import 'package:coffee/src/presentation/product/bloc/product_state.dart';
import 'package:coffee/src/presentation/product/widgets/product_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/utils/constants/constants.dart';
import '../../signup/widgets/custom_text_input.dart';
import 'choose_size.dart';

class BodyProduct extends StatelessWidget {
  const BodyProduct({
    Key? key,
    required this.controller,
    required this.isTop,
  }) : super(key: key);

  final TextEditingController controller;
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
          children: [const ProductDescription(), body(context)],
        ),
      ),
    );
  }

  Widget body(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        sizeProduct(),
        const SizedBox(height: 10),
        const Divider(color: Colors.black),
        const SizedBox(height: 10),
        Row(
          children: [
            const Icon(FontAwesomeIcons.fileLines),
            const SizedBox(width: 5),
            Text(
              "note".translate(context),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 5),
            Text("optional".translate(context)),
          ],
        ),
        const SizedBox(height: 15),
        CustomTextInput(
          controller: controller,
          hint: "note".translate(context),
          colorBorder: Colors.black87,
        ),
      ],
    );
  }

  Widget sizeProduct() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is DataTransmissionState) {
          return Row(
            children: [
              chooseSize(
                "S",
                state.product.sizeIndex == 0,
                () {
                  context.read<ProductBloc>().add(DataTransmissionEvent(
                      product: state.product.copyWith(sizeIndex: 0)));
                },
              ),
              const SizedBox(width: 10),
              chooseSize(
                "M",
                state.product.sizeIndex == 1,
                () {
                  context.read<ProductBloc>().add(DataTransmissionEvent(
                      product: state.product.copyWith(sizeIndex: 1)));
                },
              ),
              const SizedBox(width: 10),
              chooseSize(
                "L",
                state.product.sizeIndex == 2,
                () {
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
