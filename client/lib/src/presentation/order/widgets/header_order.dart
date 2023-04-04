import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/presentation/order/bloc/order_bloc.dart';
import 'package:coffee/src/presentation/order/bloc/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        if (state is InitState || state is OrderLoading) {
          return _buildLoading();
        }
        if (state is OrderError) {
          return Center(child: Text(state.message!));
        }
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
              unselectedLabelColor: const Color.fromRGBO(45, 216, 198, 1),
              // unselectedLabelStyle: const TextStyle(fontSize: 16),
              indicatorColor: Colors.green,
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
