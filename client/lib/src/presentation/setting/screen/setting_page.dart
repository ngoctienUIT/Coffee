import 'package:coffee/src/controls/extension/string_extension.dart';
import 'package:coffee/src/presentation/change_password/screen/change_password_page.dart';
import 'package:flutter/material.dart';

import '../../../controls/route_function.dart';
import '../../other/widgets/group_item_other.dart';
import '../../other/widgets/item_other.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "setting".translate(context),
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
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
                    screen: const ChangePasswordPage(),
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
