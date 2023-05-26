import 'package:coffee_admin/src/presentation/other/bloc/other_bloc.dart';
import 'package:coffee_admin/src/presentation/other/bloc/other_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/bloc/service_bloc.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../data/models/preferences_model.dart';
import '../widgets/body_other.dart';
import '../widgets/header_other.dart';

class OtherPage extends StatefulWidget {
  const OtherPage({Key? key}) : super(key: key);

  @override
  State<OtherPage> createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    PreferencesModel preferencesModel =
        context.read<ServiceBloc>().preferencesModel;
    return BlocProvider(
      create: (context) => OtherBloc(preferencesModel)..add(FetchData()),
      child: const Scaffold(
        backgroundColor: AppColors.statusBarColor,
        body: SafeArea(
          child: Column(
            children: [
              HeaderOtherPage(),
              Expanded(child: BodyOtherPage()),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
