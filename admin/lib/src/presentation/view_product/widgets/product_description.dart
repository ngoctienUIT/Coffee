import 'package:coffee_admin/src/core/utils/extensions/int_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/view_product_bloc.dart';
import '../bloc/view_product_state.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewProductBloc, ViewProductState>(
      builder: (context, state) {
        if (state is DataTransmissionState) {
          return Column(
            children: [
              Row(
                children: [
                  Text(
                    state.product.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    state.product.getTotal().toCurrency(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(state.product.description.toString()),
            ],
          );
        }
        return Container();
      },
    );
  }
}
