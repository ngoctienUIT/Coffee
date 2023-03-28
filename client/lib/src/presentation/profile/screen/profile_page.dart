import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/domain/entities/user/user_response.dart';
import 'package:coffee/src/presentation/profile/widgets/header_profile.dart';
import 'package:coffee/src/presentation/voucher/widgets/app_bar_general.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/constants/constants.dart';
import '../widgets/body_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key, required this.user}) : super(key: key);

  final UserResponse user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.statusBarColor,
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
