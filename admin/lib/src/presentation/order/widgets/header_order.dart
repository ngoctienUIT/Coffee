import 'package:coffee_admin/src/core/utils/constants/app_colors.dart';
import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
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
            Tab(text: "all".translate(context)),
            Tab(text: "placed".translate(context)),
            Tab(text: "completed".translate(context)),
            Tab(text: "cancelled".translate(context)),
          ],
        ),
      ),
    );
  }
}
