import 'package:coffee_admin/src/domain/entities/user/user_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../profile/screen/profile_page.dart';
import '../bloc/account_bloc.dart';
import '../bloc/account_event.dart';
import '../bloc/account_state.dart';
import 'item_account.dart';

class BodyAccount extends StatelessWidget {
  const BodyAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        if (state is InitState || state is AccountLoading) {
          return _buildLoading();
        }
        if (state is AccountError) {
          return Center(
            child: Text(state.message!),
          );
        }
        if (state is AccountLoaded) {
          List<UserResponse> listAccount = state.listAccount;
          int indexState = state.index;

          return RefreshIndicator(
            onRefresh: () async {
              context.read<AccountBloc>().add(RefreshData(indexState));
            },
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: listAccount.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(createRoute(
                      screen: ProfilePage(
                        user: listAccount[index],
                        onChange: () {
                          context
                              .read<AccountBloc>()
                              .add(RefreshData(indexState));
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
                            onPressed: (context) {
                              context.read<AccountBloc>().add(DeleteEvent(
                                  listAccount[index].id, indexState));
                            },
                            backgroundColor: AppColors.statusBarColor,
                            foregroundColor:
                                const Color.fromRGBO(231, 231, 231, 1),
                            icon: FontAwesomeIcons.trash,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ],
                      ),
                      child: ItemAccount(user: listAccount[index])),
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
