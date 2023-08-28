import 'package:coffee_admin/injection.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    return BlocProvider<SettingBloc>(
      create: (context) => getIt<SettingBloc>(),
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
          customToast(context,
              AppLocalizations.of(context)!.accountDeletedSuccessfully);
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
        appBar: AppBarGeneral(
            title: AppLocalizations.of(context)?.setting, elevation: 0),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              groupItemOther(AppLocalizations.of(context)!.accountSettings, [
                itemOther(
                  AppLocalizations.of(context)!.deleteAccount,
                  Icons.delete_forever,
                  () => _showAlertDialog(context, () {
                    Navigator.pop(context);
                    context.read<SettingBloc>().add(DeleteAccountEvent());
                  }),
                ),
              ]),
              if (user.password.isNotEmpty)
                groupItemOther(AppLocalizations.of(context)!.security, [
                  itemOther(
                    AppLocalizations.of(context)!.changePassword,
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
          title: AppLocalizations.of(context)!.deleteAccount,
          content: AppLocalizations.of(context)!.youWantDeleteYourAccount,
          onOK: onOK,
        );
      },
    );
  }
}
