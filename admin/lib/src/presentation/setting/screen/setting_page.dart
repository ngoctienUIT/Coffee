import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../../../core/function/route_function.dart';
import '../../../domain/entities/user/user_response.dart';
import '../../change_password/screen/change_password_page.dart';
import '../../forgot_password/widgets/app_bar_general.dart';
import '../../other/widgets/group_item_other.dart';
import '../../other/widgets/item_other.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key, required this.user}) : super(key: key);

  final UserResponse user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGeneral(title: "setting".translate(context), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            groupItemOther("account_settings".translate(context), [
              itemOther(
                "delete_account".translate(context),
                Icons.delete_forever,
                () {},
              ),
            ]),
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
    );
  }
}
