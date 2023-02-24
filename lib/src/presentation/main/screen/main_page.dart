import 'package:coffee/src/presentation/order/screen/order_page.dart';
import 'package:coffee/src/presentation/other/screen/other_page.dart';
import 'package:coffee/src/presentation/store/screen/store_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../controls/on_will_pop.dart';
import '../../activate/screen/activate_page.dart';
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
    const HomePage(),
    const OrderPage(),
    const ActivatePage(),
    const StorePage(),
    const OtherPage(),
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.cartShopping),
            label: 'Đặt hàng',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.clockRotateLeft),
            label: 'Hoạt động',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.store),
            label: 'Cửa hàng',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.bars),
            label: 'Khác',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: currentTab,
        selectedItemColor: const Color.fromRGBO(173, 149, 121, 1),
        unselectedItemColor: Colors.grey,
        iconSize: 20,
        onTap: (value) => setState(() => currentTab = value),
        elevation: 5,
      ),
    );
  }
}
