import 'package:coffee_admin/src/presentation/order/bloc/order_bloc.dart';
import 'package:coffee_admin/src/presentation/order/bloc/order_event.dart';
import 'package:coffee_admin/src/presentation/order/widgets/body_order.dart';
import 'package:coffee_admin/src/presentation/order/widgets/header_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/constants/constants.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => OrderBloc()..add(FetchData()),
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: SafeArea(
          child: Column(
            children: const [
              HeaderOrderPage(),
              SizedBox(height: 10),
              Expanded(child: BodyOrder()),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
