import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/presentation/other/bloc/other_bloc.dart';
import 'package:coffee/src/presentation/other/bloc/other_state.dart';
import 'package:coffee/src/presentation/setting/screen/setting_page.dart';
import 'package:coffee/src/presentation/signup/screen/signup_page.dart';
import 'package:coffee/src/presentation/voucher/screen/voucher_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main.dart';
import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../info/screen/info_page.dart';
import '../../login/widgets/custom_button.dart';
import '../../profile/screen/profile_page.dart';
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
            if (isLogin)
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
                  Navigator.of(context).push(createRoute(
                    screen: const SettingPage(),
                    begin: const Offset(1, 0),
                  ));
                })
              ]),
            if (isLogin)
              groupItemOther("interact".translate(context), [
                itemOther("voucher".translate(context), Icons.local_activity,
                    () {
                  Navigator.of(context).push(createRoute(
                    screen: const VoucherPage(),
                    begin: const Offset(1, 0),
                  ));
                }),
                itemOther("activity".translate(context),
                    Icons.card_giftcard_rounded, () {}),
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
            if (isLogin)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: customButton(
                  text: "logout".translate(context),
                  isOnPress: true,
                  onPress: () {
                    GoogleSignIn().signOut();
                    FacebookAuth.instance.logOut();
                    SharedPreferences.getInstance()
                        .then((value) => value.setBool("isLogin", false));
                    Navigator.of(context).pushReplacement(createRoute(
                      screen: const SignUpPage(),
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
