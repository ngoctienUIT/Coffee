import 'package:coffee_admin/src/presentation/product/bloc/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/route_function.dart';
import '../../../core/services/bloc/service_bloc.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../data/models/preferences_model.dart';
import '../../add_product/screen/add_product_page.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../widgets/body_product.dart';
import '../widgets/header_product.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PreferencesModel preferencesModel =
        context.read<ServiceBloc>().preferencesModel;
    return BlocProvider(
      create: (context) => ProductBloc(preferencesModel)..add(FetchData()),
      child: const ProductView(),
    );
  }
}

class ProductView extends StatefulWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    PreferencesModel preferencesModel =
        context.read<ServiceBloc>().preferencesModel;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: const SafeArea(
        child: Column(
          children: [
            HeaderProductPage(),
            SizedBox(height: 20),
            Expanded(child: BodyProductPage()),
          ],
        ),
      ),
      floatingActionButton: preferencesModel.user!.userRole == "ADMIN"
          ? FloatingActionButton(
              onPressed: () {
                final state = context.read<ProductBloc>().state;
                Navigator.of(context).push(createRoute(
                  screen: AddProductPage(
                    onChange: () {
                      int index = 0;
                      if (state is ProductLoaded) {
                        index = state.index;
                      } else {
                        index = 0;
                      }
                      context.read<ProductBloc>().add(UpdateData(index));
                    },
                  ),
                  begin: const Offset(0, 1),
                ));
              },
              backgroundColor: AppColors.statusBarColor,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  @override
  bool get wantKeepAlive => true;
}