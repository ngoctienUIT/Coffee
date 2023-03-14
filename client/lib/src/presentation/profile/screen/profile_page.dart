import 'package:coffee/src/controls/extension/string_extension.dart';
import 'package:coffee/src/presentation/profile/widgets/header_profile.dart';
import 'package:coffee/src/presentation/voucher/widgets/app_bar_general.dart';
import 'package:flutter/material.dart';

import '../widgets/body_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(177, 40, 48, 1),
      appBar: AppBarGeneral(title: "profile".translate(context), elevation: 0),
      body: Column(
        children: const [
          HeaderProfilePage(),
          Expanded(child: BodyProfilePage()),
        ],
      ),
    );
  }
}
