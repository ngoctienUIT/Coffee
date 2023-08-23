import 'package:coffee/src/core/services/bloc/service_bloc.dart';
import 'package:coffee/src/core/services/bloc/service_event.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:coffee/src/presentation/main/widgets/bottom_bar.dart';
import 'package:coffee/src/presentation/order/screen/order_page.dart';
import 'package:coffee/src/presentation/other/screen/other_page.dart';
import 'package:coffee/src/presentation/store/screen/store_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/function/network_connectivity.dart';
import '../../../core/function/notification_services.dart';
import '../../../core/function/on_will_pop.dart';
import '../../../core/function/route_function.dart';
import '../../../core/services/bloc/service_state.dart';
import '../../activity/screen/activity_page.dart';
import '../../home/screen/home_page.dart';
import '../../login/screen/login_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.checkConnect}) : super(key: key);

  final bool checkConnect;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentTab = 0;
  DateTime? currentBackPressTime;
  final PageStorageBucket bucket = PageStorageBucket();
  final PageController _pageController = PageController();
  late List<Widget> screens;
  NotificationServices notificationServices = NotificationServices();
  late NetworkConnectivity _networkConnectivity;

  @override
  void initState() {
    if (!widget.checkConnect) {
      _networkConnectivity = NetworkConnectivity.instance;
      initConnect();
    }
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
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
    context.read<ServiceBloc>().add(CheckLoginEvent());
    super.initState();
  }

  void initConnect() {
    _networkConnectivity.initialise();
    _networkConnectivity.myStream.listen((source) {
      print('main source $source');
      switch (source) {
        case ConnectivityResult.mobile:
        case ConnectivityResult.wifi:
          customToast(context,
              AppLocalizations.of(context).internetConnectionIsAvailable);
          break;
        case ConnectivityResult.none:
          customToast(
              context, AppLocalizations.of(context).noInternetConnection);
          break;
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    if (!widget.checkConnect) {
      _networkConnectivity.disposeStream();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ServiceBloc, ServiceState>(
      listener: (context, state) {
        if (state is LogOutState) {
          customToast(context,
              AppLocalizations.of(context).loginExpiredPleaseLoginAgain);
          Navigator.of(context).pushAndRemoveUntil(
            createRoute(
              screen: const LoginPage(),
              begin: const Offset(0, 1),
            ),
            (route) => false,
          );
        }
      },
      child: Scaffold(
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
