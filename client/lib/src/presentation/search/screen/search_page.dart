import 'package:coffee/src/presentation/order/widgets/list_product_loading.dart';
import 'package:coffee/src/presentation/search/bloc/search_bloc.dart';
import 'package:coffee/src/presentation/search/bloc/search_event.dart';
import 'package:coffee/src/presentation/search/bloc/search_state.dart';
import 'package:coffee/src/presentation/search/widgets/app_bar_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/constants/constants.dart';
import '../../order/widgets/grid_item_order.dart';
import '../../order/widgets/list_item_order.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchFoodController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SearchBloc()..add(SearchProduct(query: searchFoodController.text)),
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBarSearch(controller: searchFoodController),
        body: const SearchView(),
      ),
    );
  }
}

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  bool check = true;

  @override
  Widget build(BuildContext context) {
    return Column(children: [header(), body()]);
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          const Spacer(),
          InkWell(
            onTap: () => setState(() => check = true),
            child: Icon(
              Icons.menu,
              color: check ? Colors.red : Colors.grey,
              size: 35,
            ),
          ),
          InkWell(
            onTap: () => setState(() => check = false),
            child: Icon(
              Icons.grid_view_rounded,
              color: check ? Colors.grey : Colors.red,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }

  Widget body() {
    return BlocBuilder<SearchBloc, SearchState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        print(state);
        if (state is SearchLoaded) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: check
                  ? ListItemOrder(listProduct: state.listProduct)
                  : GridItemOrder(listProduct: state.listProduct),
            ),
          );
        }
        return Expanded(child: listProductLoading());
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
