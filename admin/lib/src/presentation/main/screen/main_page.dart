import 'package:coffee_admin/injection.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:coffee_admin/src/data/models/user.dart';
import 'package:coffee_admin/src/presentation/account_management/screen/account_management_page.dart';
import 'package:coffee_admin/src/presentation/order/screen/order_page.dart';
import 'package:coffee_admin/src/presentation/product/screen/product_page.dart';
import 'package:coffee_admin/src/presentation/store/screen/store_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/function/notification_services.dart';
import '../../../core/function/on_will_pop.dart';
import '../../../core/utils/language/bloc/language_cubit.dart';
import '../../coupon/screen/coupon_page.dart';
import '../../other/screen/other_page.dart';
import '../../view_order/screen/view_order_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, this.id}) : super(key: key);
  final String? id;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  NotificationServices notificationServices = NotificationServices();
  final PageStorageBucket bucket = PageStorageBucket();
  final PageController _pageController = PageController();
  DateTime? currentBackPressTime;
  int currentTab = 0;
  late List<Widget> screens;

  @override
  void initState() {
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    User user = getIt<User>();
    screens = [
      const OrderPage(key: PageStorageKey<String>('HomePage')),
      const ProductPage(key: PageStorageKey<String>('OrderPage')),
      const CouponPage(key: PageStorageKey<String>('ActivityPage')),
      user.userRole == "ADMIN"
          ? const AccountManagementPage(
              key: PageStorageKey<String>('AccountManage'))
          : const StorePage(key: PageStorageKey<String>('StorePage')),
      const OtherPage(key: PageStorageKey<String>('OtherPage')),
    ];
    context
        .read<LanguageCubit>()
        .startNewTimer(context, const Duration(hours: 1));
    super.initState();
    if (widget.id != null) {
      if (mounted) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewOrderPage(id: widget.id)));
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User user = getIt<User>();
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => onWillPop(
          context: context,
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
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(FontAwesomeIcons.cartShopping),
            label: AppLocalizations.of(context)!.order,
          ),
          BottomNavigationBarItem(
            icon: const Icon(FontAwesomeIcons.productHunt),
            label: AppLocalizations.of(context)!.product,
          ),
          BottomNavigationBarItem(
            icon: const Icon(FontAwesomeIcons.gift),
            label: AppLocalizations.of(context)?.voucher,
          ),
          user.userRole == "ADMIN"
              ? BottomNavigationBarItem(
                  icon: currentTab == 3
                      ? const Icon(FontAwesomeIcons.userLarge)
                      : const Icon(FontAwesomeIcons.user),
                  label: AppLocalizations.of(context)!.staff,
                )
              : BottomNavigationBarItem(
                  icon: const Icon(FontAwesomeIcons.store),
                  label: AppLocalizations.of(context)!.store,
                ),
          BottomNavigationBarItem(
            icon: const Icon(FontAwesomeIcons.bars),
            label: AppLocalizations.of(context)!.other,
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: currentTab,
        selectedItemColor: const Color.fromRGBO(173, 149, 121, 1),
        unselectedItemColor: Colors.grey,
        iconSize: 20,
        backgroundColor: Colors.white,
        onTap: (value) {
          _pageController.animateToPage(
            value,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
          setState(() => currentTab = value);
        },
        elevation: 10,
      ),
    );
  }
}
