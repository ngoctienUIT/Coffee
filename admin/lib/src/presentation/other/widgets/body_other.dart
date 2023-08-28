import 'package:coffee_admin/injection.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:coffee_admin/src/data/models/user.dart';
import 'package:coffee_admin/src/presentation/login/screen/login_page.dart';
import 'package:coffee_admin/src/presentation/login/widgets/custom_button.dart';
import 'package:coffee_admin/src/presentation/policy/screen/policy_page.dart';
import 'package:coffee_admin/src/presentation/product_catalogues/screen/product_catalogues_page.dart';
import 'package:coffee_admin/src/presentation/recommend/screen/recommend_page.dart';
import 'package:coffee_admin/src/presentation/signup/screen/signup_page.dart';
import 'package:coffee_admin/src/presentation/store/screen/store_page.dart';
import 'package:coffee_admin/src/presentation/tag/screen/tag_page.dart';
import 'package:coffee_admin/src/presentation/topping/screen/topping_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../core/utils/language/bloc/language_cubit.dart';
import '../../info/screen/info_page.dart';
import '../../profile/screen/profile_page.dart';
import '../../setting/screen/setting_page.dart';
import 'group_item_other.dart';
import 'item_other.dart';

class BodyOtherPage extends StatelessWidget {
  const BodyOtherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = getIt<User>();
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
            groupItemOther(AppLocalizations.of(context)!.account, [
              itemOther(AppLocalizations.of(context)!.profile, Icons.person,
                  () {
                if (getIt.isRegistered<User>()) {
                  Navigator.of(context).push(createRoute(
                    screen: ProfilePage(user: getIt<User>()),
                    begin: const Offset(1, 0),
                  ));
                }
              }),
              const Divider(),
              itemOther(AppLocalizations.of(context)!.setting, Icons.settings,
                  () {
                if (getIt.isRegistered<User>()) {
                  Navigator.of(context).push(createRoute(
                    screen: SettingPage(user: getIt<User>()),
                    begin: const Offset(1, 0),
                  ));
                }
              })
            ]),
            groupItemOther(AppLocalizations.of(context)!.manage, [
              if (user.userRole == "ADMIN")
                itemOther(AppLocalizations.of(context)!.createAccount,
                    Icons.account_circle_outlined, () {
                  Navigator.of(context).push(createRoute(
                    screen: SignUpPage(role: user.userRole),
                    begin: const Offset(1, 0),
                  ));
                }),
              if (user.userRole == "ADMIN") const Divider(),
              if (user.userRole == "ADMIN")
                itemOther(AppLocalizations.of(context)!.recommend, Icons.cloud,
                    () {
                  Navigator.of(context).push(createRoute(
                    screen: const RecommendPage(),
                    begin: const Offset(1, 0),
                  ));
                }),
              if (user.userRole == "ADMIN") const Divider(),
              if (user.userRole == "ADMIN")
                itemOther(AppLocalizations.of(context)!.store, Icons.store, () {
                  Navigator.of(context).push(createRoute(
                    screen: const StorePage(),
                    begin: const Offset(1, 0),
                  ));
                }),
              if (user.userRole == "ADMIN") const Divider(),
              itemOther(AppLocalizations.of(context)!.productCatalogues,
                  FontAwesomeIcons.mugSaucer, () {
                Navigator.of(context).push(createRoute(
                  screen: const ProductCataloguesPage(),
                  begin: const Offset(1, 0),
                ));
              }),
              const Divider(),
              itemOther("Tag", FontAwesomeIcons.tags, () {
                Navigator.of(context).push(createRoute(
                  screen: const TagPage(),
                  begin: const Offset(1, 0),
                ));
              }),
              const Divider(),
              itemOther("Topping", FontAwesomeIcons.apple, () {
                Navigator.of(context).push(createRoute(
                  screen: const ToppingPage(),
                  begin: const Offset(1, 0),
                ));
              }),
            ]),
            groupItemOther(AppLocalizations.of(context)!.generalInfo, [
              itemOther(AppLocalizations.of(context)!.policy, Icons.file_copy,
                  () {
                Navigator.of(context).push(createRoute(
                  screen: const PolicyPage(),
                  begin: const Offset(1, 0),
                ));
              }),
              const Divider(),
              itemOther(AppLocalizations.of(context)!.appInfo, Icons.info, () {
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
                text: AppLocalizations.of(context)!.logout,
                isOnPress: true,
                onPress: () {
                  context.read<LanguageCubit>().stopTimer();
                  SharedPreferences.getInstance()
                      .then((value) => value.setBool("isLogin", false));
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
