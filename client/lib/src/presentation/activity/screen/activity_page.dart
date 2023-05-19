import 'package:coffee/src/core/services/bloc/service_bloc.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/presentation/activity/bloc/activity_bloc.dart';
import 'package:coffee/src/presentation/activity/bloc/activity_event.dart';
import 'package:coffee/src/presentation/activity/widgets/custom_app_bar.dart';
import 'package:coffee/src/presentation/activity/widgets/list_activity.dart';
import 'package:coffee/src/presentation/main/bloc/main_bloc.dart';
import 'package:coffee/src/presentation/main/bloc/main_state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/constants/constants.dart';
import '../../../data/models/preferences_model.dart';
import '../../main/bloc/main_event.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({Key? key, this.isAppBar = false, required this.check})
      : super(key: key);

  final bool isAppBar;
  final bool check;

  @override
  Widget build(BuildContext context) {
    PreferencesModel preferencesModel =
        context.read<ServiceBloc>().preferencesModel;
    return BlocProvider(
      create: (context) => ActivityBloc(preferencesModel)..add(FetchData(0)),
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: CustomAppBar(
          elevation: 0,
          isPick: isAppBar,
          title: "activity".translate(context),
          onChange: () {
            if (check) {
              context.read<MainBloc>().add(ChangeCartHomeEvent());
              context.read<MainBloc>().add(ChangeCartOrderEvent());
            }
          },
        ),
        body: SafeArea(child: ActivityView(check: check)),
      ),
    );
  }
}

class ActivityView extends StatefulWidget {
  const ActivityView({Key? key, required this.check}) : super(key: key);

  final bool check;

  @override
  State<ActivityView> createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _activityController;

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      context.read<ActivityBloc>().add(UpdateData(_activityController.index));
    });
    _activityController = TabController(length: 2, vsync: this);
    _activityController.addListener(() => setState(() {
          context
              .read<ActivityBloc>()
              .add(FetchData(_activityController.index));
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.check
        ? BlocListener<MainBloc, MainState>(
            listener: (context, state) {
              if (state is UpdateActivityState) {
                context
                    .read<ActivityBloc>()
                    .add(UpdateData(_activityController.index));
              }
            },
            child: buildBody(),
          )
        : buildBody();
  }

  Widget buildBody() {
    return Column(
      children: [
        const SizedBox(height: 8),
        Container(
          height: 50,
          color: Colors.white,
          child: TabBar(
            controller: _activityController,
            isScrollable: false,
            labelColor: Colors.black87,
            labelStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            unselectedLabelColor: AppColors.statusBarColor,
            unselectedLabelStyle: const TextStyle(fontSize: 16),
            indicatorColor: AppColors.statusBarColor,
            tabs: [
              Tab(text: "going_on".translate(context)),
              Tab(text: "order_history".translate(context)),
            ],
          ),
        ),
        const Expanded(child: ListActivity()),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
