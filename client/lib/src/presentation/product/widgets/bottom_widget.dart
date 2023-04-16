import 'package:coffee/src/core/utils/extensions/int_extension.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/presentation/product/bloc/product_bloc.dart';
import 'package:coffee/src/presentation/product/bloc/product_event.dart';
import 'package:coffee/src/presentation/product/bloc/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/constants/constants.dart';
import '../../../data/models/product.dart';
import 'choose_quantity.dart';

class BottomWidget extends StatelessWidget {
  const BottomWidget({Key? key, required this.isEdit, this.index})
      : super(key: key);

  final bool isEdit;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      buildWhen: (previous, current) =>
          current is! AddProductToOrderSuccessState ||
          current is! AddProductToOrderErrorState ||
          current is! AddProductToOrderLoadingState,
      builder: (context, state) {
        Product product = context.read<ProductBloc>().product.copyWith();
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 75,
          child: Row(
            children: [
              chooseQuantity(product.number, (value) {
                product.number = value;
                context
                    .read<ProductBloc>()
                    .add(DataTransmissionEvent(product: product));
              }),
              const SizedBox(width: 20),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.statusBarColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90),
                      ),
                    ),
                    onPressed: isEdit
                        ? () {
                            if (product.number == 0) {
                              context
                                  .read<ProductBloc>()
                                  .add(DeleteProductEvent(index!));
                            } else {
                              context
                                  .read<ProductBloc>()
                                  .add(UpdateProductEvent(product, index!));
                            }
                          }
                        : (product.number > 0
                            ? () {
                                context
                                    .read<ProductBloc>()
                                    .add(AddProductToOrderEvent(product));
                              }
                            : null),
                    child: Text(
                      isEdit
                          ? (product.number == 0
                              ? "Xóa"
                              : "Cập nhật ${product.getTotal().toCurrency()}")
                          : "${"add".translate(context)} ${product.getTotal().toCurrency()}",
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
