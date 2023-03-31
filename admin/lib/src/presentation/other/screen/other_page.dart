import 'package:coffee_admin/src/presentation/other/bloc/other_bloc.dart';
import 'package:coffee_admin/src/presentation/other/bloc/other_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/constants/constants.dart';
import '../widgets/body_other.dart';
import '../widgets/header_other.dart';

class OtherPage extends StatelessWidget {
  const OtherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtherBloc()..add(FetchData()),
      child: Scaffold(
        backgroundColor: AppColors.statusBarColor,
        body: SafeArea(
          child: Column(
            children: const [
              HeaderOtherPage(),
              Expanded(child: BodyOtherPage()),
            ],
          ),
        ),
      ),
    );
  }
}
