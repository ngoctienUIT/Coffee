import 'dart:math';

import 'package:coffee/injection.dart';
import 'package:coffee/src/core/services/bloc/service_bloc.dart';
import 'package:coffee/src/core/services/bloc/service_state.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/presentation/activity/bloc/activity_bloc.dart';
import 'package:coffee/src/presentation/activity/bloc/activity_event.dart';
import 'package:coffee/src/presentation/activity/widgets/custom_app_bar.dart';
import 'package:coffee/src/presentation/activity/widgets/list_activity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/utils/constants/constants.dart';
import '../../store/widgets/item_loading.dart';
import '../bloc/activity_state.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({Key? key, this.isAppBar = false}) : super(key: key);

  final bool isAppBar;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ActivityBloc>(
      create: (context) => getIt<ActivityBloc>()..add(FetchData(0)),
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: CustomAppBar(
          elevation: 0,
          isPick: isAppBar,
          title: "activity".translate(context),
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
    return BlocListener<ServiceBloc, ServiceState>(
      listener: (context, state) {
        if (state is PlacedOrderState) {
          context
              .read<ActivityBloc>()
              .add(UpdateData(_activityController.index));
        }
      },
      child: Column(
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
          Expanded(
            child: BlocConsumer<ActivityBloc, ActivityState>(
              listener: (context, state) {
                if (state is ActivityError) {
                  customToast(context, state.message.toString());
                }
              },
              builder: (context, state) {
                if (state is ActivityLoaded || state is UpdateSuccess) {
                  final listOrder = state is ActivityLoaded
                      ? state.listOrder
                      : (state as UpdateSuccess).listOrder;
                  int indexState = state is ActivityLoaded
                      ? state.index
                      : (state as UpdateSuccess).index;
                  if (listOrder.isNotEmpty) {
                    return ListActivity(
                      listOrder: listOrder,
                      indexState: indexState,
                    );
                  }
                  return Center(child: Text("no_data".translate(context)));
                }
                return _buildLoading();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    var rng = Random();
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      physics: const BouncingScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          child: Row(
            children: [
              const SizedBox(width: 10),
              itemLoading(70, 70, 0),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 8),
                    itemLoading(20, double.infinity, 10),
                    const SizedBox(height: 8),
                    itemLoading(15, 150, 10),
                    const SizedBox(height: 8),
                    itemLoading(15, 100, 10),
                    const SizedBox(height: 8),
                    itemLoading(20, rng.nextDouble() * 50 + 100, 10),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: const Icon(Icons.arrow_forward_ios_outlined),
              ),
              const SizedBox(width: 10),
            ],
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
