import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:coffee_admin/src/presentation/login/screen/login_page.dart';
import 'package:coffee_admin/src/presentation/login/widgets/custom_button.dart';
import 'package:coffee_admin/src/presentation/other/bloc/other_event.dart';
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
import '../../../core/language/bloc/language_cubit.dart';
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
                    screen: ProfilePage(
                      user: otherState.user,
                      onChange: () {
                        context.read<OtherBloc>().add(FetchData());
                      },
                    ),
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
              itemOther("create_account".translate(context),
                  Icons.account_circle_outlined, () {
                OtherState otherState = context.read<OtherBloc>().state;
                if (otherState is OtherLoaded) {
                  Navigator.of(context).push(createRoute(
                    screen: SignUpPage(role: otherState.user.userRole),
                    begin: const Offset(1, 0),
                  ));
                }
              }),
              const Divider(),
              itemOther("Recommendation", Icons.cloud, () {
                Navigator.of(context).push(createRoute(
                  screen: const RecommendPage(),
                  begin: const Offset(1, 0),
                ));
              }),
              const Divider(),
              itemOther("store".translate(context), Icons.store, () {
                Navigator.of(context).push(createRoute(
                  screen: const StorePage(),
                  begin: const Offset(1, 0),
                ));
              }),
              const Divider(),
              itemOther("product catalogues", FontAwesomeIcons.mugSaucer, () {
                Navigator.of(context).push(createRoute(
                  screen: const ProductCataloguesPage(),
                  begin: const Offset(1, 0),
                ));
              }),
              const Divider(),
              itemOther("tag", FontAwesomeIcons.tags, () {
                Navigator.of(context).push(createRoute(
                  screen: const TagPage(),
                  begin: const Offset(1, 0),
                ));
              }),
              const Divider(),
              itemOther("topping", FontAwesomeIcons.apple, () {
                Navigator.of(context).push(createRoute(
                  screen: const ToppingPage(),
                  begin: const Offset(1, 0),
                ));
              }),
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
