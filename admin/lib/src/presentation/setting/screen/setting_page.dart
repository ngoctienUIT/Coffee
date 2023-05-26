import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/function/loading_animation.dart';
import '../../../core/function/route_function.dart';
import '../../../core/widgets/custom_alert_dialog.dart';
import '../../../data/models/user.dart';
import '../../change_password/screen/change_password_page.dart';
import '../../forgot_password/widgets/app_bar_general.dart';
import '../../login/screen/login_page.dart';
import '../../other/widgets/group_item_other.dart';
import '../../other/widgets/item_other.dart';
import '../bloc/setting_bloc.dart';
import '../bloc/setting_event.dart';
import '../bloc/setting_state.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingBloc(),
      child: SettingView(user: user),
    );
  }
}

class SettingView extends StatelessWidget {
  const SettingView({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingBloc, SettingState>(
      listener: (context, state) {
        if (state is DeleteErrorState) {
          Navigator.pop(context);
          customToast(context, state.error);
        }
        if (state is DeleteLoadingState) {
          loadingAnimation(context);
        }
        if (state is DeleteSuccessState) {
          customToast(
              context, "account_deleted_successfully".translate(context));
          Navigator.of(context).pushAndRemoveUntil(
            createRoute(
              screen: const LoginPage(),
              begin: const Offset(0, 1),
            ),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar:
            AppBarGeneral(title: "setting".translate(context), elevation: 0),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              groupItemOther("account_settings".translate(context), [
                itemOther(
                  "delete_account".translate(context),
                  Icons.delete_forever,
                  () => _showAlertDialog(context, () {
                    Navigator.pop(context);
                    context.read<SettingBloc>().add(DeleteAccountEvent());
                  }),
                ),
              ]),
              if (user.password.isNotEmpty)
                groupItemOther("security".translate(context), [
                  itemOther(
                    "change_password".translate(context),
                    Icons.lock,
                    () {
                      Navigator.of(context).push(createRoute(
                        screen: ChangePasswordPage(user: user),
                        begin: const Offset(1, 0),
                      ));
                    },
                  ),
                ]),
            ],
          ),
        ),
      ),
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
          content: 'you_want_delete_your_account'.translate(context),
          onOK: onOK,
        );
      },
    );
  }
}
