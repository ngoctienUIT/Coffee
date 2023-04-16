import 'package:coffee/src/core/function/loading_animation.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/domain/entities/user/user_response.dart';
import 'package:coffee/src/presentation/profile/bloc/profile_bloc.dart';
import 'package:coffee/src/presentation/profile/widgets/header_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/utils/constants/constants.dart';
import '../../coupon/widgets/app_bar_general.dart';
import '../bloc/profile_state.dart';
import '../widgets/body_profile.dart';

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
        body: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is SaveProfileLoading) {
              loadingAnimation(context);
            }
            if (state is SaveProfileError) {
              customToast(context, state.message.toString());
              Navigator.pop(context);
            }
            if (state is DeleteAvatarErrorState) {
              customToast(context, state.error);
            }
          },
          child: Column(
            children: [
              HeaderProfilePage(user: user, onChange: onChange),
              Expanded(child: BodyProfilePage(user: user, onChange: onChange)),
            ],
          ),
        ),
      ),
    );
  }
}
