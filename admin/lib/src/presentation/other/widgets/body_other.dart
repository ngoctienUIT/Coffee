import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:coffee_admin/src/presentation/login/screen/login_page.dart';
import 'package:coffee_admin/src/presentation/login/widgets/custom_button.dart';
import 'package:coffee_admin/src/presentation/signup/screen/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../info/screen/info_page.dart';
import '../../profile/screen/profile_page.dart';
import '../../setting/screen/setting_page.dart';
import '../bloc/other_bloc.dart';
import '../bloc/other_state.dart';
import 'group_item_other.dart';
import 'item_other.dart';

class BodyOtherPage extends StatelessWidget {
  const BodyOtherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        color: AppColors.bgColor,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            groupItemOther("account".translate(context), [
              itemOther("profile".translate(context), Icons.person, () {
                OtherState otherState = context.read<OtherBloc>().state;
                if (otherState is OtherLoaded) {
                  Navigator.of(context).push(createRoute(
                    screen: ProfilePage(user: otherState.user),
                    begin: const Offset(1, 0),
                  ));
                }
              }),
              const Divider(),
              itemOther("setting".translate(context), Icons.settings, () {
                OtherState otherState = context.read<OtherBloc>().state;
                if (otherState is OtherLoaded) {
                  Navigator.of(context).push(createRoute(
                    screen: SettingPage(user: otherState.user),
                    begin: const Offset(1, 0),
                  ));
                }
              })
            ]),
            groupItemOther("manage".translate(context), [
              itemOther(
                "create_account".translate(context),
                Icons.account_circle_outlined,
                () {
                  Navigator.of(context).push(createRoute(
                    screen: const SignUpPage(),
                    begin: const Offset(1, 0),
                  ));
                },
              ),
              const Divider(),
              itemOther("user".translate(context), Icons.people, () {}),
              const Divider(),
              itemOther("store".translate(context), Icons.store, () {}),
            ]),
            groupItemOther("general_info".translate(context), [
              itemOther("policy".translate(context), Icons.file_copy, () {}),
              const Divider(),
              itemOther("app_info".translate(context), Icons.info, () {
                Navigator.of(context).push(createRoute(
                  screen: const InfoPage(),
                  begin: const Offset(1, 0),
                ));
              })
            ]),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: customButton(
                text: "logout".translate(context),
                isOnPress: true,
                onPress: () {
                  Navigator.of(context).pushReplacement(createRoute(
                    screen: const LoginPage(),
                    begin: const Offset(0, 1),
                  ));
                },
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
