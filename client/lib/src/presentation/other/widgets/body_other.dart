import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/presentation/activity/screen/activity_page.dart';
import 'package:coffee/src/presentation/policy/screen/policy_page.dart';
import 'package:coffee/src/presentation/setting/screen/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/function/route_function.dart';
import '../../../core/services/bloc/service_bloc.dart';
import '../../../core/services/language/bloc/language_cubit.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../data/models/preferences_model.dart';
import '../../../domain/firebase/firebase_service.dart';
import '../../coupon/screen/coupon_page.dart';
import '../../info/screen/info_page.dart';
import '../../login/screen/login_page.dart';
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
            groupItemOther("account".translate(context), [
              itemOther("profile".translate(context), Icons.person, () {
                PreferencesModel preferencesModel =
                    context.read<ServiceBloc>().preferencesModel;
                Navigator.of(context).push(createRoute(
                  screen: ProfilePage(user: preferencesModel.user!),
                  begin: const Offset(1, 0),
                ));
              }),
              const Divider(),
              itemOther("setting".translate(context), Icons.settings, () {
                PreferencesModel preferencesModel =
                    context.read<ServiceBloc>().preferencesModel;
                Navigator.of(context).push(createRoute(
                  screen: SettingPage(user: preferencesModel.user!),
                  begin: const Offset(1, 0),
                ));
              })
            ]),
            groupItemOther("interact".translate(context), [
              itemOther("voucher".translate(context), Icons.local_activity, () {
                Navigator.of(context).push(createRoute(
                  screen: const CouponPage(),
                  begin: const Offset(1, 0),
                ));
              }),
              itemOther(
                  "activity".translate(context), Icons.card_giftcard_rounded,
                  () {
                Navigator.of(context).push(createRoute(
                  screen: const ActivityPage(isAppBar: true),
                  begin: const Offset(1, 0),
                ));
              }),
            ]),
            groupItemOther("general_info".translate(context), [
              itemOther("policy".translate(context), Icons.file_copy, () {
                Navigator.of(context).push(createRoute(
                  screen: const PolicyPage(),
                  begin: const Offset(1, 0),
                ));
              }),
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
                  GoogleSignIn().signOut();
                  context.read<LanguageCubit>().stopTimer();
                  SharedPreferences.getInstance()
                      .then((value) => value.setBool("isLogin", false));
                  deleteTokenFCM();
                  Navigator.of(context).pushAndRemoveUntil(
                    createRoute(
                      screen: const LoginPage(),
                      begin: const Offset(0, 1),
                    ),
                    (route) => false,
                  );
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
