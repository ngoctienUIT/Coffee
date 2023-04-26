import 'dart:math';

import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:coffee_admin/src/presentation/coupon/bloc/coupon_bloc.dart';
import 'package:coffee_admin/src/presentation/coupon/bloc/coupon_event.dart';
import 'package:coffee_admin/src/presentation/coupon/bloc/coupon_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../add_coupon/screen/add_coupon_page.dart';
import '../../order/widgets/item_loading.dart';
import '../widgets/ticket_widget.dart';

class CouponPage extends StatelessWidget {
  const CouponPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CouponBloc()..add(FetchData()),
      child: const CouponView(),
    );
  }
}

class CouponView extends StatefulWidget {
  const CouponView({Key? key}) : super(key: key);

  @override
  State<CouponView> createState() => _CouponViewState();
}

class _CouponViewState extends State<CouponView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        elevation: 0,
        centerTitle: true,
        leading: const SizedBox(),
        title: Text(
          "all_vouchers".translate(context),
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(createRoute(
            screen: AddCouponPage(
              onChange: () {
                context.read<CouponBloc>().add(FetchData());
              },
            ),
            begin: const Offset(0, 1),
          ));
        },
        backgroundColor: AppColors.statusBarColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildBody() {
    return BlocConsumer<CouponBloc, CouponState>(
      listener: (context, state) {
        if (state is CouponError) {
          customToast(context, state.message.toString());
        }
      },
      builder: (context, state) {
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
                      extentRatio: 0.35,
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            Navigator.of(context).push(createRoute(
                              screen: AddCouponPage(
                                onChange: () {
                                  context.read<CouponBloc>().add(FetchData());
                                },
                                coupon: state.listCoupon[index],
                              ),
                              begin: const Offset(0, 1),
                            ));
                          },
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
                      image: state.listCoupon[index].imageUrl ?? "",
                      date: state.listCoupon[index].dueDate,
                    ),
                  ),
                );
              },
            ),
          );
        }
        return _buildLoading();
      },
    );
  }

  Widget _buildLoading() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(10),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: itemTicketLoading(),
        );
      },
    );
  }

  Widget itemTicketLoading() {
    var rng = Random();
    return Container(
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 8),
            color: Colors.black.withOpacity(0.1),
            blurRadius: 37,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipPath(
            clipper: const TicketClipper(
              borderRadius: 10,
              clipRadius: 7,
              smallClipRadius: 2,
              numberOfSmallClips: 8,
            ),
            child: Container(color: Colors.white),
          ),
          SizedBox(
            height: 130,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: itemLoading(100, 100, 0),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        itemLoading(20, rng.nextDouble() * 100 + 100, 10),
                        const Spacer(),
                        itemLoading(15, double.infinity, 10),
                        const SizedBox(height: 5),
                        itemLoading(15, rng.nextDouble() * 100 + 100, 10),
                        const Spacer(),
                        itemLoading(15, 150, 10),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
