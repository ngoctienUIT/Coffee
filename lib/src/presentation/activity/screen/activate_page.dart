import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../profile/screen/profile_page.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ));
          },
          borderRadius: BorderRadius.circular(90),
          child: ClipOval(child: Image.asset("assets/coffee_logo.jpg")),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              FontAwesomeIcons.magnifyingGlass,
              color: Colors.grey,
            ),
          )
        ],
      ),
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
                tabs: const [
                  Tab(text: "Đang diễn ra"),
                  Tab(text: "Lịch sử đặt hàng")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
