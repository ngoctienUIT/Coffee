import 'package:coffee/src/presentation/main/widgets/bottom_bar.dart';
import 'package:coffee/src/presentation/order/screen/order_page.dart';
import 'package:coffee/src/presentation/other/screen/other_page.dart';
import 'package:coffee/src/presentation/store/screen/store_page.dart';
import 'package:flutter/material.dart';

import '../../../core/function/on_will_pop.dart';
import '../../activity/screen/activity_page.dart';
import '../../home/screen/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentTab = 0;
  DateTime? currentBackPressTime;
  final PageStorageBucket bucket = PageStorageBucket();
  final PageController _pageController = PageController();
  List<Widget> screens = [
    const HomePage(key: PageStorageKey<String>('HomePage')),
    const OrderPage(key: PageStorageKey<String>('OrderPage')),
    const ActivityPage(key: PageStorageKey<String>('ActivityPage')),
    const StorePage(key: PageStorageKey<String>('StorePage'), isPick: false),
    const OtherPage(key: PageStorageKey<String>('OtherPage')),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => onWillPop(
          action: (now) => currentBackPressTime = now,
          currentBackPressTime: currentBackPressTime,
        ),
        child: PageView.builder(
          controller: _pageController,
          itemCount: screens.length,
          onPageChanged: (value) => setState(() => currentTab = value),
          itemBuilder: (context, index) {
            return PageStorage(bucket: bucket, child: screens[index]);
          },
        ),
      ),
      bottomNavigationBar: BottomBar(
        currentTab: currentTab,
        onTab: (int value) {
          _pageController.animateToPage(
            value,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
          setState(() => currentTab = value);
        },
      ),
    );
  }
}
