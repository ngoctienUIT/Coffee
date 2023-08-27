import 'package:coffee_admin/injection.dart';
import 'package:coffee_admin/src/presentation/product/widgets/list_product_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/utils/constants/constants.dart';
import '../../product/widgets/list_item_product.dart';
import '../bloc/search_bloc.dart';
import '../bloc/search_event.dart';
import '../bloc/search_state.dart';
import '../widgets/app_bar_search.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (context) => getIt<SearchBloc>()..add(SearchProduct(query: "")),
      child: const SearchView(),
    );
  }
}

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController searchFoodController = TextEditingController();
  bool check = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBarSearch(controller: searchFoodController),
      body: BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) {
          if (state is SearchError) {
            customToast(context, state.message.toString());
          }
        },
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          print(state);
          if (state is SearchLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<SearchBloc>()
                      .add(SearchProduct(query: searchFoodController.text));
                },
                child: ListItemProduct(
                  listProduct: state.listProduct,
                  onDelete: (id) {},
                ),
              ),
            );
          }
          return listProductLoading();
        },
      ),
    );
  }
}
