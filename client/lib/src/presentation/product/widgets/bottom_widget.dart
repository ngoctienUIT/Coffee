import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/presentation/product/bloc/product_bloc.dart';
import 'package:coffee/src/presentation/product/bloc/product_event.dart';
import 'package:coffee/src/presentation/product/bloc/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/constants/constants.dart';
import 'choose_quantity.dart';

class BottomWidget extends StatelessWidget {
  const BottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is DataTransmissionState) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 75,
            child: Row(
              children: [
                chooseQuantity(state.product.number, (value) {
                  context.read<ProductBloc>().add(DataTransmissionEvent(
                      product: state.product.copyWith(number: value)));
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
                      onPressed: state.product.number > 0 ? () {} : null,
                      child: Text(
                        "${"add".translate(context)} ${state.product.getTotalString()}",
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
