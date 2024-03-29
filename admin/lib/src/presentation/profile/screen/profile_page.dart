import 'package:coffee_admin/injection.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/constants/constants.dart';
import '../../../data/models/user.dart';
import '../../forgot_password/widgets/app_bar_general.dart';
import '../bloc/profile_bloc.dart';
import '../widgets/body_profile.dart';
import '../widgets/header_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key, required this.user, this.onChange})
      : super(key: key);

  final User user;
  final VoidCallback? onChange;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) => getIt<ProfileBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.statusBarColor,
        appBar:
            AppBarGeneral(title: AppLocalizations.of(context)!.profile, elevation: 0),
        body: Column(
          children: [
            HeaderProfilePage(user: user),
            Expanded(child: BodyProfilePage(user: user, onChange: onChange)),
          ],
        ),
      ),
    );
  }
}
