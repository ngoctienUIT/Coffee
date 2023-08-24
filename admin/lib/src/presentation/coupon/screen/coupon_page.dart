import 'dart:math';

import 'package:coffee_admin/injection.dart';
import 'package:coffee_admin/src/core/function/loading_animation.dart';
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
import '../../../core/services/bloc/service_bloc.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../core/widgets/custom_alert_dialog.dart';
import '../../../data/models/preferences_model.dart';
import '../../../data/remote/response/coupon/coupon_response.dart';
import '../../add_coupon/screen/add_coupon_page.dart';
import '../../order/widgets/item_loading.dart';
import '../widgets/ticket_widget.dart';

class CouponPage extends StatelessWidget {
  const CouponPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CouponBloc>(
      create: (context) => getIt<CouponBloc>()..add(FetchData()),
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
  List<CouponResponse> listCoupon = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    PreferencesModel preferencesModel =
        context.read<ServiceBloc>().preferencesModel;
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
      floatingActionButton: preferencesModel.user!.userRole == "ADMIN"
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(createRoute(
                  screen: AddCouponPage(
                    onChange: () {
                      context.read<CouponBloc>().add(UpdateData());
                    },
                  ),
                  begin: const Offset(0, 1),
                ));
              },
              backgroundColor: AppColors.statusBarColor,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget buildBody() {
    return BlocConsumer<CouponBloc, CouponState>(
      listener: (context, state) {
        if (state is CouponError) {
          customToast(context, state.message.toString());
        }
        if (state is CouponLoading && !state.check) {
          loadingAnimation(context);
        }
        if (state is DeleteCouponSuccess) {
          Navigator.pop(context);
          customToast(context, "delete_successfully".translate(context));
        }
      },
      buildWhen: (previous, current) =>
          !(current is CouponLoading && !current.check),
      builder: (context, state) {
        PreferencesModel preferencesModel =
            context.read<ServiceBloc>().preferencesModel;
        if (state is CouponLoaded || state is DeleteCouponSuccess) {
          if (state is CouponLoaded) {
            listCoupon = [];
            listCoupon.addAll(state.listCoupon);
          }
          if (state is DeleteCouponSuccess) {
            listCoupon.removeWhere((element) => element.id == state.id);
          }
          return RefreshIndicator(
            onRefresh: () async {
              context.read<CouponBloc>().add(FetchData());
            },
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: const EdgeInsets.all(10),
              itemCount: listCoupon.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: preferencesModel.user!.userRole == "ADMIN"
                      ? Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            extentRatio: 0.35,
                            children: [
                              SlidableAction(
                                onPressed: (_) {
                                  Navigator.of(context).push(createRoute(
                                    screen: AddCouponPage(
                                      onChange: () {
                                        context
                                            .read<CouponBloc>()
                                            .add(FetchData());
                                      },
                                      coupon: listCoupon[index],
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
                                onPressed: (_) {
                                  _showAlertDialog(context, () {
                                    context
                                        .read<CouponBloc>()
                                        .add(DeleteEvent(listCoupon[index].id));
                                  });
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
                            onPress: null,
                            title: listCoupon[index].couponName,
                            content: listCoupon[index].content,
                            image: listCoupon[index].imageUrl ?? "",
                            date: listCoupon[index].dueDate,
                          ),
                        )
                      : TicketWidget(
                          onPress: null,
                          title: listCoupon[index].couponName,
                          content: listCoupon[index].content,
                          image: listCoupon[index].imageUrl ?? "",
                          date: listCoupon[index].dueDate,
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
              ticketHeight: 130,
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

  Future _showAlertDialog(BuildContext context, VoidCallback onOK) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return customAlertDialog(
          context: context,
          title: 'delete_voucher'.translate(context),
          content:
              'are_you_sure_you_want_to_delete_this_voucher'.translate(context),
          onOK: onOK,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
