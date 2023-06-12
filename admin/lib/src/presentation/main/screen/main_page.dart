import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:coffee_admin/src/presentation/account_management/screen/account_management_page.dart';
import 'package:coffee_admin/src/presentation/order/screen/order_page.dart';
import 'package:coffee_admin/src/presentation/product/screen/product_page.dart';
import 'package:coffee_admin/src/presentation/store/screen/store_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/function/notification_services.dart';
import '../../../core/function/on_will_pop.dart';
import '../../../core/services/bloc/service_bloc.dart';
import '../../../core/services/language/bloc/language_cubit.dart';
import '../../../data/models/preferences_model.dart';
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
    PreferencesModel preferencesModel =
        context.read<ServiceBloc>().preferencesModel;
    screens = [
      const OrderPage(key: PageStorageKey<String>('HomePage')),
      const ProductPage(key: PageStorageKey<String>('OrderPage')),
      const CouponPage(key: PageStorageKey<String>('ActivityPage')),
      preferencesModel.user!.userRole == "ADMIN"
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
    PreferencesModel preferencesModel =
        context.read<ServiceBloc>().preferencesModel;
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
            label: 'order'.translate(context),
          ),
          BottomNavigationBarItem(
            icon: const Icon(FontAwesomeIcons.productHunt),
            label: 'product'.translate(context),
          ),
          BottomNavigationBarItem(
            icon: const Icon(FontAwesomeIcons.gift),
            label: 'voucher'.translate(context),
          ),
          preferencesModel.user!.userRole == "ADMIN"
              ? BottomNavigationBarItem(
                  icon: currentTab == 3
                      ? const Icon(FontAwesomeIcons.userLarge)
                      : const Icon(FontAwesomeIcons.user),
                  label: 'staff'.translate(context),
                )
              : BottomNavigationBarItem(
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
