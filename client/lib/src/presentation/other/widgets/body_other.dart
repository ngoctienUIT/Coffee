import 'package:coffee/injection.dart';
import 'package:coffee/src/core/services/bloc/service_event.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:coffee/src/data/models/user.dart';
import 'package:coffee/src/presentation/activity/screen/activity_page.dart';
import 'package:coffee/src/presentation/policy/screen/policy_page.dart';
import 'package:coffee/src/presentation/setting/screen/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/function/route_function.dart';
import '../../../core/services/bloc/service_bloc.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../data/remote/firebase/firebase_service.dart';
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
            groupItemOther(AppLocalizations.of(context).account, [
              itemOther(AppLocalizations.of(context).profile, Icons.person, () {
                Navigator.of(context).push(createRoute(
                  screen: ProfilePage(user: getIt<User>()),
                  begin: const Offset(1, 0),
                ));
              }),
              const Divider(),
              itemOther(AppLocalizations.of(context).setting, Icons.settings,
                  () {
                Navigator.of(context).push(createRoute(
                  screen: SettingPage(user: getIt<User>()),
                  begin: const Offset(1, 0),
                ));
              })
            ]),
            groupItemOther(AppLocalizations.of(context).interact, [
              itemOther(
                  AppLocalizations.of(context).voucher, Icons.local_activity,
                  () {
                Navigator.of(context).push(createRoute(
                  screen: const CouponPage(),
                  begin: const Offset(1, 0),
                ));
              }),
              itemOther(AppLocalizations.of(context).activity,
                  Icons.card_giftcard_rounded, () {
                Navigator.of(context).push(createRoute(
                  screen: const ActivityPage(isAppBar: true),
                  begin: const Offset(1, 0),
                ));
              }),
            ]),
            groupItemOther(AppLocalizations.of(context).generalInfo, [
              itemOther(AppLocalizations.of(context).policy, Icons.file_copy,
                  () {
                Navigator.of(context).push(createRoute(
                  screen: const PolicyPage(),
                  begin: const Offset(1, 0),
                ));
              }),
              const Divider(),
              itemOther(AppLocalizations.of(context).appInfo, Icons.info, () {
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
                text: AppLocalizations.of(context).logout,
                isOnPress: true,
                onPress: () {
                  GoogleSignIn().signOut();
                  context.read<ServiceBloc>().add(StopTimeEvent());
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
