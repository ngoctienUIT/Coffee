import 'package:coffee_admin/injection.dart';
import 'package:coffee_admin/src/presentation/order/bloc/order_bloc.dart';
import 'package:coffee_admin/src/presentation/order/bloc/order_event.dart';
import 'package:coffee_admin/src/presentation/order/widgets/body_order.dart';
import 'package:coffee_admin/src/presentation/order/widgets/header_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../data/remote/response/order/order_response.dart';
import '../bloc/order_state.dart';
import '../widgets/list_order_loading.dart';

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
    return BlocProvider(
      create: (context) => getIt<OrderBloc>()..add(FetchData()),
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: SafeArea(
          child: Column(
            children: [
              const HeaderOrderPage(),
              const SizedBox(height: 10),
              Expanded(
                child: BlocConsumer<OrderBloc, OrderState>(
                  listener: (context, state) {
                    if (state is OrderError) {
                      customToast(context, state.message.toString());
                    }
                  },
                  buildWhen: (previous, current) =>
                      current is! ChangeOrderListState,
                  builder: (context, state) {
                    if (state is OrderLoaded) {
                      List<OrderResponse> listOrder = state.listOrder;
                      int indexState = state.index;
                      return BodyOrder(
                        listOrder: listOrder,
                        indexState: indexState,
                      );
                    }
                    return listOrderLoading();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
