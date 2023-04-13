import 'package:coffee_admin/src/presentation/product/widgets/list_product_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/constants/constants.dart';
import '../../product/widgets/list_item_product.dart';
import '../bloc/search_bloc.dart';
import '../bloc/search_event.dart';
import '../bloc/search_state.dart';
import '../widgets/app_bar_search.dart';

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
    return BlocBuilder<SearchBloc, SearchState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        print(state);
        if (state is SearchLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListItemProduct(
              listProduct: state.listProduct,
              onDelete: (id) {},
            ),
          );
        }
        return listProductLoading();
      },
    );
  }
}
