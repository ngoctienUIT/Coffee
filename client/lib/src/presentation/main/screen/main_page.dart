import 'package:coffee/src/controls/extension/string_extension.dart';
import 'package:coffee/src/presentation/order/screen/order_page.dart';
import 'package:coffee/src/presentation/other/screen/other_page.dart';
import 'package:coffee/src/presentation/store/screen/store_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../controls/function/on_will_pop.dart';
import '../../activity/screen/activity_page.dart';
import '../../home/screen/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageStorageBucket bucket = PageStorageBucket();
  DateTime? currentBackPressTime;
  int currentTab = 0;
  List<Widget> screens = [
    const HomePage(key: PageStorageKey<String>('HomePage')),
    const OrderPage(key: PageStorageKey<String>('OrderPage')),
    const ActivityPage(key: PageStorageKey<String>('ActivityPage')),
    const StorePage(key: PageStorageKey<String>('StorePage')),
    const OtherPage(key: PageStorageKey<String>('OtherPage')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => onWillPop(
          action: (now) => currentBackPressTime = now,
          currentBackPressTime: currentBackPressTime,
        ),
        child: PageStorage(
          bucket: bucket,
          child: screens[currentTab],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(FontAwesomeIcons.house),
            label: 'home'.translate(context),
          ),
          BottomNavigationBarItem(
            icon: const Icon(FontAwesomeIcons.cartShopping),
            label: 'order'.translate(context),
          ),
          BottomNavigationBarItem(
            icon: const Icon(FontAwesomeIcons.clockRotateLeft),
            label: 'activity'.translate(context),
          ),
          BottomNavigationBarItem(
            icon: const Icon(FontAwesomeIcons.store),
            label: 'store'.translate(context),
          ),
          BottomNavigationBarItem(
            icon: const Icon(FontAwesomeIcons.bars),
            label: 'other'.translate(context),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: currentTab,
        selectedItemColor: const Color.fromRGBO(173, 149, 121, 1),
        unselectedItemColor: Colors.grey,
        iconSize: 20,
        backgroundColor: Colors.white,
        onTap: (value) => setState(() => currentTab = value),
        elevation: 10,
      ),
    );
  }
}
