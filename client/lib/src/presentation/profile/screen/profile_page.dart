import 'package:coffee/injection.dart';
import 'package:coffee/src/core/function/loading_animation.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/presentation/profile/bloc/profile_bloc.dart';
import 'package:coffee/src/presentation/profile/widgets/header_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../data/models/user.dart';
import '../../coupon/widgets/app_bar_general.dart';
import '../bloc/profile_state.dart';
import '../widgets/body_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) => getIt<ProfileBloc>(),
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
              HeaderProfilePage(user: user),
              Expanded(child: BodyProfilePage(user: user)),
            ],
          ),
        ),
      ),
    );
  }
}
