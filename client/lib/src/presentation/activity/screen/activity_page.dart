import 'package:coffee/src/controls/extension/string_extension.dart';
import 'package:coffee/src/presentation/activity/widgets/custom_app_bar.dart';
import 'package:coffee/src/presentation/activity/widgets/list_activity.dart';
import 'package:flutter/material.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage>
    with TickerProviderStateMixin {
  late TabController _activityController;

  @override
  void initState() {
    _activityController = TabController(length: 2, vsync: this);
    _activityController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
      appBar: const CustomAppBar(elevation: 0),
      body: SafeArea(
        child: Column(
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
        ),
      ),
    );
  }
}
