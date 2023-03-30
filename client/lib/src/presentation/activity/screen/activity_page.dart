import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/presentation/activity/bloc/activity_bloc.dart';
import 'package:coffee/src/presentation/activity/bloc/activity_event.dart';
import 'package:coffee/src/presentation/activity/bloc/activity_state.dart';
import 'package:coffee/src/presentation/activity/widgets/custom_app_bar.dart';
import 'package:coffee/src/presentation/activity/widgets/list_activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/constants/constants.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActivityBloc()..add(FetchData(0)),
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: const CustomAppBar(elevation: 0),
        body: SafeArea(child: BlocBuilder<ActivityBloc, ActivityState>(
          builder: (context, state) {
            return const ActivityView();
          },
        )),
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
    with TickerProviderStateMixin {
  late TabController _activityController;

  @override
  void initState() {
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
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: TabBar(
            controller: _activityController,
            isScrollable: false,
            labelColor: Colors.black87,
            labelStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            unselectedLabelColor: const Color.fromRGBO(45, 216, 198, 1),
            unselectedLabelStyle: const TextStyle(fontSize: 16),
            indicatorColor: Colors.green,
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
}
