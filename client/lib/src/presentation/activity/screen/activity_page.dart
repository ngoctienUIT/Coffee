import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../controls/route_function.dart';
import '../../profile/screen/profile_page.dart';
import '../../search/screen/search_page.dart';

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
            Navigator.of(context).push(createRoute(
              screen: const ProfilePage(),
              begin: const Offset(1, 0),
            ));
          },
          borderRadius: BorderRadius.circular(90),
          child: ClipOval(child: Image.asset("assets/coffee_logo.jpg")),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(createRoute(
                screen: const SearchPage(),
                begin: const Offset(1, 0),
              ));
            },
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
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {},
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return InkWell(onTap: () {}, child: itemActivity());
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget itemActivity() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Image.asset("assets/tea.png", height: 50),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text("Tại cửa hàng"),
                      Spacer(),
                      Text("105.000đ"),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text("Tại cửa hàng"),
                      const Spacer(),
                      Text(
                        DateFormat("hh:mm - dd/MM/yyyy").format(DateTime.now()),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_outlined)
          ],
        ),
      ),
    );
  }
}
