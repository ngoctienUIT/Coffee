import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/presentation/coupon/bloc/coupon_bloc.dart';
import 'package:coffee/src/presentation/coupon/bloc/coupon_event.dart';
import 'package:coffee/src/presentation/coupon/bloc/coupon_state.dart';
import 'package:coffee/src/presentation/coupon/widgets/app_bar_general.dart';
import 'package:coffee/src/presentation/coupon/widgets/ticket_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/constants/constants.dart';

class CouponPage extends StatelessWidget {
  const CouponPage({Key? key, this.onPress}) : super(key: key);

  final Function(String id)? onPress;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CouponBloc()..add(FetchData()),
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar:
            AppBarGeneral(title: "your_offer".translate(context), elevation: 0),
        body: CouponView(onPress: onPress),
      ),
    );
  }
}

class CouponView extends StatelessWidget {
  const CouponView({Key? key, this.onPress}) : super(key: key);

  final Function(String id)? onPress;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CouponBloc, CouponState>(
      builder: (context, state) {
        if (state is InitState || state is CouponLoading) {
          return _buildLoading();
        }
        if (state is CouponError) {
          return Center(child: Text(state.message!));
        }
        if (state is CouponLoaded) {
          return RefreshIndicator(
            onRefresh: () async {},
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(10),
              itemCount: state.listCoupon.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TicketWidget(
                    onPress: () => onPress!(state.listCoupon[index].id),
                    title: state.listCoupon[index].couponName,
                    image: state.listCoupon[index].imageUrl,
                    content: state.listCoupon[index].content,
                    date: state.listCoupon[index].dueDate,
                  ),
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
