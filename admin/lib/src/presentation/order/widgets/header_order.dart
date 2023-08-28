import 'package:coffee_admin/src/core/utils/constants/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/order_bloc.dart';
import '../bloc/order_event.dart';

class HeaderOrderPage extends StatefulWidget {
  const HeaderOrderPage({Key? key}) : super(key: key);

  @override
  State<HeaderOrderPage> createState() => _HeaderOrderPageState();
}

class _HeaderOrderPageState extends State<HeaderOrderPage>
    with TickerProviderStateMixin {
  late TabController _orderController;

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      context.read<OrderBloc>().add(UpdateData(_orderController.index));
    });
    _orderController = TabController(length: 4, vsync: this);
    _orderController.addListener(() {
      context.read<OrderBloc>().add(RefreshData(_orderController.index));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 56,
      width: double.infinity,
      child: Center(
        child: TabBar(
          controller: _orderController,
          isScrollable: true,
          labelColor: Colors.black87,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelColor: AppColors.statusBarColor,
          unselectedLabelStyle: const TextStyle(fontSize: 16),
          indicatorColor: AppColors.statusBarColor,
          tabs: [
            Tab(text: AppLocalizations.of(context)!.placed),
            Tab(text: AppLocalizations.of(context)!.completed),
            Tab(text: AppLocalizations.of(context)!.cancelled),
            Tab(text: AppLocalizations.of(context)!.all),
          ],
        ),
      ),
    );
  }
}
