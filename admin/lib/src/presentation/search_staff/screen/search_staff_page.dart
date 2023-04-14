import 'package:coffee_admin/src/presentation/account_management/widgets/list_account_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../account_management/widgets/item_account.dart';
import '../../profile/screen/profile_page.dart';
import '../bloc/search_staff_bloc.dart';
import '../bloc/search_staff_event.dart';
import '../bloc/search_staff_state.dart';
import '../widgets/app_bar_search.dart';

class SearchStaffPage extends StatefulWidget {
  const SearchStaffPage({Key? key}) : super(key: key);

  @override
  State<SearchStaffPage> createState() => _SearchStaffPageState();
}

class _SearchStaffPageState extends State<SearchStaffPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SearchStaffBloc()..add(SearchStaff(searchController.text)),
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBarSearch(controller: searchController),
        body: const SearchStaffView(),
      ),
    );
  }
}

class SearchStaffView extends StatefulWidget {
  const SearchStaffView({Key? key}) : super(key: key);

  @override
  State<SearchStaffView> createState() => _SearchStaffViewState();
}

class _SearchStaffViewState extends State<SearchStaffView> {
  bool check = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchStaffBloc, SearchStaffState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        print(state);
        if (state is SearchLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              // context
              //     .read<SearchStaffBloc>()
              //     .add(SearchStaffEvent(sea));
            },
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  itemCount: state.listUser.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(createRoute(
                          screen: ProfilePage(
                            user: state.listUser[index],
                            onChange: () {
                              // context
                              //     .read<SearchStaffBloc>()
                              //     .add(SearchStaffEvent(sea));
                            },
                          ),
                          begin: const Offset(1, 0),
                        ));
                      },
                      child: Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            extentRatio: 0.2,
                            children: [
                              SlidableAction(
                                onPressed: (context) {},
                                backgroundColor: AppColors.statusBarColor,
                                foregroundColor:
                                    const Color.fromRGBO(231, 231, 231, 1),
                                icon: FontAwesomeIcons.trash,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ],
                          ),
                          child: ItemAccount(user: state.listUser[index])),
                    );
                  },
                )),
          );
        }
        return listAccountLoading();
      },
    );
  }
}
