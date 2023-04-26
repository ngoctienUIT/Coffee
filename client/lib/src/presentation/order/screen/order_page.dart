import 'package:coffee/src/presentation/main/bloc/main_bloc.dart';
import 'package:coffee/src/presentation/main/bloc/main_event.dart';
import 'package:coffee/src/presentation/order/bloc/order_bloc.dart';
import 'package:coffee/src/presentation/order/bloc/order_event.dart';
import 'package:coffee/src/presentation/order/bloc/order_state.dart';
import 'package:coffee/src/presentation/order/widgets/body_order.dart';
import 'package:coffee/src/presentation/order/widgets/bottom_sheet_order.dart';
import 'package:coffee/src/presentation/order/widgets/header_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/utils/constants/constants.dart';

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
    return BlocProvider<OrderBloc>(
      create: (_) => OrderBloc()..add(FetchData()),
      child: BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is AddProductToCartError) {
            customToast(context, state.message.toString());
          }
          if (state is OrderError) {
            customToast(context, state.message.toString());
          }
          if (state is RefreshOrderError) {
            customToast(context, state.message.toString());
          }
          if (state is AddProductToCartLoaded) {
            context.read<MainBloc>().add(ChangeCartHomeEvent());
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.bgColor,
          body: SafeArea(
            child: Column(
              children: const [
                HeaderOrderPage(),
                SizedBox(height: 20),
                Expanded(child: BodyOrderPage()),
                SizedBox(height: 56),
              ],
            ),
          ),
          bottomSheet: const BottomSheetOrder(),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
