import 'package:coffee_admin/src/presentation/product/bloc/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../add_product/screen/add_product_page.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../widgets/body_product.dart';
import '../widgets/header_product.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc()..add(FetchData()),
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: SafeArea(
          child: Column(
            children: const [
              HeaderProductPage(),
              SizedBox(height: 20),
              Expanded(child: BodyProductPage()),
            ],
          ),
        ),
        floatingActionButton: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(createRoute(
                  screen: AddProductPage(
                    onChange: () {
                      int index = 0;
                      if (state is RefreshLoaded) {
                        index = state.index;
                      } else {
                        index = 0;
                      }
                      context.read<ProductBloc>().add(RefreshData(index));
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
