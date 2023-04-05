import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../search/screen/search_page.dart';
import '../../signup/widgets/custom_text_input.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';

class HeaderProductPage extends StatefulWidget {
  const HeaderProductPage({Key? key}) : super(key: key);

  @override
  State<HeaderProductPage> createState() => _HeaderProductPageState();
}

class _HeaderProductPageState extends State<HeaderProductPage>
    with TickerProviderStateMixin {
  late TabController _productController;

  @override
  void initState() {
    _productController = TabController(length: 0, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [search(context), tabBar(context)]);
  }

  Widget search(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SizedBox(
        height: 40,
        child: CustomTextInput(
          hint: "search_name_dish".translate(context),
          radius: 90,
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          textStyle: const TextStyle(fontSize: 13),
          backgroundColor: AppColors.bgColor,
          onPress: () {
            Navigator.of(context).push(createRoute(
              screen: const SearchPage(),
              begin: const Offset(1, 0),
            ));
          },
          suffixIcon: const Icon(
            FontAwesomeIcons.magnifyingGlass,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget tabBar(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      buildWhen: (previous, current) =>
          current is ProductLoading ||
          current is ProductLoaded ||
          current is ProductError,
      builder: (context, state) {
        if (state is InitState || state is ProductLoading) {
          return _buildLoading();
        }
        if (state is ProductError) {
          return Center(child: Text(state.message!));
        }
        if (state is ProductLoaded) {
          _productController = TabController(
              length: state.listProductCatalogues.length, vsync: this);
          _productController.addListener(() {
            context
                .read<ProductBloc>()
                .add(RefreshData(_productController.index));
          });
          return SizedBox(
            height: 115,
            child: TabBar(
              controller: _productController,
              physics: const BouncingScrollPhysics(),
              isScrollable: true,
              labelColor: Colors.black87,
              // labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelColor: AppColors.statusBarColor,
              // unselectedLabelStyle: const TextStyle(fontSize: 16),
              indicatorColor: AppColors.statusBarColor,
              tabs: List.generate(
                state.listProductCatalogues.length,
                (index) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width / 3.7,
                    child: Column(
                      children: [
                        Image.network(
                          state.listProductCatalogues[index].image,
                          height: 70,
                        ),
                        Text(
                          state.listProductCatalogues[index].name.toUpperCase(),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
