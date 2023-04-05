import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/constants/constants.dart';
import '../bloc/account_bloc.dart';
import '../bloc/account_event.dart';
import '../widgets/body_account.dart';
import '../widgets/header_account.dart';

class AccountManagementPage extends StatelessWidget {
  const AccountManagementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountBloc()..add(FetchData()),
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: SafeArea(
          child: Column(
            children: const [
              HeaderAccountPage(),
              SizedBox(height: 10),
              Expanded(child: BodyAccount()),
            ],
          ),
        ),
      ),
    );
  }
}
