import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/presentation/order/bloc/order_bloc.dart';
import 'package:coffee/src/presentation/order/bloc/order_state.dart';
import 'package:coffee/src/presentation/order/widgets/list_product_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../search/screen/search_page.dart';
import '../../signup/widgets/custom_text_input.dart';
import '../bloc/order_event.dart';

class HeaderOrderPage extends StatefulWidget {
  const HeaderOrderPage({Key? key}) : super(key: key);

  @override
  State<HeaderOrderPage> createState() => _HeaderOrderPageState();
}

class _HeaderOrderPageState extends State<HeaderOrderPage>
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
    return BlocBuilder<OrderBloc, OrderState>(
      buildWhen: (previous, current) =>
          current is OrderLoading ||
          current is OrderLoaded ||
          current is OrderError,
      builder: (context, state) {
        if (state is OrderLoaded) {
          _productController = TabController(
              length: state.listProductCatalogues.length, vsync: this);
          _productController.addListener(() {
            context
                .read<OrderBloc>()
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
                        CachedNetworkImage(
                          height: 70,
                          width: 70,
                          imageUrl: state.listProductCatalogues[index].image,
                          placeholder: (context, url) => itemProductLoading(70),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
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
        return _buildLoading();
      },
    );
  }

  Widget _buildLoading() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                itemProductLoading(70),
                const SizedBox(height: 5),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 35,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
