import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/constants/constants.dart';
import '../../../domain/entities/user/user_response.dart';
import '../../forgot_password/widgets/app_bar_general.dart';
import '../bloc/profile_bloc.dart';
import '../widgets/body_profile.dart';
import '../widgets/header_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key, required this.user, required this.onChange})
      : super(key: key);

  final UserResponse user;
  final VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: Scaffold(
        backgroundColor: AppColors.statusBarColor,
        appBar:
            AppBarGeneral(title: "profile".translate(context), elevation: 0),
        body: Column(
          children: [
            HeaderProfilePage(avatar: user.imageUrl),
            Expanded(child: BodyProfilePage(user: user, onChange: onChange)),
          ],
        ),
      ),
    );
  }
}
