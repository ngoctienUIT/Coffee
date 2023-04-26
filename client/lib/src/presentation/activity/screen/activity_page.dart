import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/presentation/activity/bloc/activity_bloc.dart';
import 'package:coffee/src/presentation/activity/bloc/activity_event.dart';
import 'package:coffee/src/presentation/activity/widgets/custom_app_bar.dart';
import 'package:coffee/src/presentation/activity/widgets/list_activity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/constants/constants.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({Key? key, this.isAppBar = false}) : super(key: key);

  final bool isAppBar;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActivityBloc()..add(FetchData(0)),
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: CustomAppBar(
          elevation: 0,
          isPick: isAppBar,
          title: "Hoạt động",
        ),
        body: const SafeArea(child: ActivityView()),
      ),
    );
  }
}

class ActivityView extends StatefulWidget {
  const ActivityView({Key? key}) : super(key: key);

  @override
  State<ActivityView> createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _activityController;

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
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
