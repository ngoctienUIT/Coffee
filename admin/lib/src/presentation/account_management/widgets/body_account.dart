import 'package:coffee_admin/src/core/function/custom_toast.dart';
import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:coffee_admin/src/data/models/user.dart';
import 'package:coffee_admin/src/domain/entities/user/user_response.dart';
import 'package:coffee_admin/src/presentation/account_management/widgets/list_account_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../core/widgets/custom_alert_dialog.dart';
import '../../profile/screen/profile_page.dart';
import '../bloc/account_bloc.dart';
import '../bloc/account_event.dart';
import '../bloc/account_state.dart';
import 'item_account.dart';

class BodyAccount extends StatelessWidget {
  const BodyAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state is AccountError) {
          customToast(context, state.message.toString());
        }
      },
      builder: (context, state) {
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
                  onTap: listAccount[index].userRole != "ADMIN"
                      ? () {
                          Navigator.of(context).push(createRoute(
                            screen: ProfilePage(
                              user: User.fromUserResponse(listAccount[index]),
                              onChange: () {
                                context
                                    .read<AccountBloc>()
                                    .add(UpdateData(indexState));
                              },
                            ),
                            begin: const Offset(1, 0),
                          ));
                        }
                      : null,
                  child: listAccount[index].userRole != "ADMIN"
                      ? Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            extentRatio: 0.2,
                            children: [
                              SlidableAction(
                                onPressed: (_) {
                                  _showAlertDialog(context, () {
                                    context.read<AccountBloc>().add(DeleteEvent(
                                        listAccount[index].id, indexState));
                                  });
                                },
                                backgroundColor: AppColors.statusBarColor,
                                foregroundColor:
                                    const Color.fromRGBO(231, 231, 231, 1),
                                icon: FontAwesomeIcons.trash,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ],
                          ),
                          child: ItemAccount(user: listAccount[index]),
                        )
                      : ItemAccount(user: listAccount[index]),
                );
              },
            ),
          );
        }
        return listAccountLoading();
      },
    );
  }

  Future _showAlertDialog(BuildContext context, VoidCallback onOK) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return customAlertDialog(
          context: context,
          title: 'delete_account'.translate(context),
          content:
              'are_you_sure_you_want_to_delete_this_account'.translate(context),
          onOK: onOK,
        );
      },
    );
  }
}
