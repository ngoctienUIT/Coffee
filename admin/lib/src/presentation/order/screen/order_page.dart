import 'package:coffee_admin/src/presentation/order/bloc/order_bloc.dart';
import 'package:coffee_admin/src/presentation/order/bloc/order_event.dart';
import 'package:coffee_admin/src/presentation/order/widgets/body_order.dart';
import 'package:coffee_admin/src/presentation/order/widgets/header_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/bloc/service_bloc.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../data/models/preferences_model.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    PreferencesModel preferencesModel =
        context.read<ServiceBloc>().preferencesModel;
    return BlocProvider(
      create: (context) => OrderBloc(preferencesModel)..add(FetchData()),
      child: const Scaffold(
        backgroundColor: AppColors.bgColor,
        body: SafeArea(
          child: Column(
            children: [
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
