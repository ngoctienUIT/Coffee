import 'package:coffee/src/core/language/bloc/language_cubit.dart';
import 'package:coffee/src/presentation/main/widgets/bottom_bar.dart';
import 'package:coffee/src/presentation/order/screen/order_page.dart';
import 'package:coffee/src/presentation/other/screen/other_page.dart';
import 'package:coffee/src/presentation/store/screen/store_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../main.dart';
import '../../../core/function/notification_services.dart';
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
  late List<Widget> screens;

  @override
  void initState() {
    listenNotification();
    screens = [
      const HomePage(key: PageStorageKey<String>('HomePage')),
      const OrderPage(key: PageStorageKey<String>('OrderPage')),
      const ActivityPage(key: PageStorageKey<String>('ActivityPage')),
      StorePage(
        key: const PageStorageKey<String>('StorePage'),
        isPick: false,
        onChange: () => toPage(1),
      ),
      const OtherPage(key: PageStorageKey<String>('OtherPage')),
    ];
    context.read<LanguageCubit>().checkLogin(context);
    super.initState();
  }

  void listenNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      Map<String, dynamic> data = message.data;

      if (message.notification != null) {
        RemoteNotification notification = message.notification!;
        print('Message also contained a notification: ${message.notification}');
        NotificationServices.showNotification(
          id: data["id"].hashCode,
          title: notification.title!,
          body: notification.body!,
          fln: flutterLocalNotificationsPlugin,
        );
      }
    });
  }

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
      bottomNavigationBar: BottomBar(
        currentTab: currentTab,
        onTab: (value) {
          toPage(value);
          setState(() => currentTab = value);
        },
      ),
    );
  }

  void toPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
