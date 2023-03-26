import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/presentation/setting/screen/setting_page.dart';
import 'package:coffee/src/presentation/signup/screen/signup_page.dart';
import 'package:coffee/src/presentation/voucher/screen/voucher_page.dart';
import 'package:flutter/material.dart';

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
            groupItemOther("account".translate(context), [
              itemOther("profile".translate(context), Icons.person, () {
                Navigator.of(context).push(createRoute(
                  screen: const ProfilePage(),
                  begin: const Offset(1, 0),
                ));
              }),
              const Divider(),
              itemOther("setting".translate(context), Icons.settings, () {
                Navigator.of(context).push(createRoute(
                  screen: const SettingPage(),
                  begin: const Offset(1, 0),
                ));
              })
            ]),
            groupItemOther("interact".translate(context), [
              itemOther("voucher".translate(context), Icons.local_activity, () {
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: customButton(
                text: "logout".translate(context),
                isOnPress: true,
                onPress: () {
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
