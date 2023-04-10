import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:coffee_admin/src/presentation/coupon/bloc/coupon_bloc.dart';
import 'package:coffee_admin/src/presentation/coupon/bloc/coupon_event.dart';
import 'package:coffee_admin/src/presentation/coupon/bloc/coupon_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../add_coupon/screen/add_coupon_page.dart';
import '../widgets/ticket_widget.dart';

class CouponPage extends StatelessWidget {
  const CouponPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "all_vouchers".translate(context),
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: BlocProvider(
        create: (context) => CouponBloc()..add(FetchData()),
        child: const SafeArea(child: CouponView()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(createRoute(
            screen: const AddCouponPage(),
            begin: const Offset(0, 1),
          ));
        },
        backgroundColor: AppColors.statusBarColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CouponView extends StatelessWidget {
  const CouponView({Key? key}) : super(key: key);

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
            onRefresh: () async {
              context.read<CouponBloc>().add(FetchData());
            },
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: const EdgeInsets.all(10),
              itemCount: state.listCoupon.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      extentRatio: 0.32,
                      children: [
                        SlidableAction(
                          onPressed: (context) {},
                          backgroundColor: AppColors.statusBarColor,
                          foregroundColor:
                              const Color.fromRGBO(231, 231, 231, 1),
                          icon: FontAwesomeIcons.penToSquare,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        SlidableAction(
                          onPressed: (context) {
                            context
                                .read<CouponBloc>()
                                .add(DeleteEvent(state.listCoupon[index].id));
                          },
                          backgroundColor: AppColors.statusBarColor,
                          foregroundColor:
                              const Color.fromRGBO(231, 231, 231, 1),
                          icon: FontAwesomeIcons.trash,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ],
                    ),
                    child: TicketWidget(
                      onPress: () {},
                      title: state.listCoupon[index].couponName,
                      content: state.listCoupon[index].content,
                      image: "assets/banner.jpg",
                      date: state.listCoupon[index].dueDate,
                    ),
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
