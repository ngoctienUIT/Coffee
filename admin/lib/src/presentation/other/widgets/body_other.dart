import 'package:coffee_admin/src/controls/extension/string_extension.dart';
import 'package:coffee_admin/src/presentation/login/screen/login_page.dart';
import 'package:coffee_admin/src/presentation/login/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../../controls/function/route_function.dart';
import '../../info/screen/info_page.dart';
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
        color: Color.fromRGBO(241, 241, 241, 1),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
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
