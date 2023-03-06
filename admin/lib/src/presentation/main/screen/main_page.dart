import 'package:coffee_admin/src/presentation/order/screen/order_page.dart';
import 'package:coffee_admin/src/presentation/product/sreen/product_page.dart';
import 'package:coffee_admin/src/presentation/special_offer/screen/special_offer_page.dart';
import 'package:coffee_admin/src/presentation/voucher/screen/voucher_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../controls/on_will_pop.dart';

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
    const OrderPage(key: PageStorageKey<String>('HomePage')),
    const ProductPage(key: PageStorageKey<String>('OrderPage')),
    const VoucherPage(key: PageStorageKey<String>('ActivityPage')),
    const SpecialOfferPage(key: PageStorageKey<String>('StorePage')),
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
            icon: Icon(FontAwesomeIcons.cartShopping),
            label: 'Đơn hàng',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.productHunt),
            label: 'Sản phẩm',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.gift),
            label: 'Voucher',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.gifts),
            label: 'Khuyến mãi',
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
