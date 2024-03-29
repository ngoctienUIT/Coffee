import 'dart:math';

import 'package:coffee/injection.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:coffee/src/presentation/coupon/bloc/coupon_bloc.dart';
import 'package:coffee/src/presentation/coupon/bloc/coupon_event.dart';
import 'package:coffee/src/presentation/coupon/bloc/coupon_state.dart';
import 'package:coffee/src/presentation/coupon/widgets/app_bar_general.dart';
import 'package:coffee/src/presentation/coupon/widgets/ticket_widget.dart';
import 'package:coffee/src/presentation/store/widgets/item_loading.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../view_special_offer/screen/view_special_offer_page.dart';

class CouponPage extends StatelessWidget {
  const CouponPage({Key? key, this.onPress, this.id, this.onDelete})
      : super(key: key);

  final Function(String id)? onPress;
  final VoidCallback? onDelete;
  final String? id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CouponBloc>(
      create: (context) => getIt<CouponBloc>()..add(FetchData()),
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBarGeneral(
          title: AppLocalizations.of(context).yourOffer,
          elevation: 0,
          onAction: onDelete,
          action: id == null ? null : AppLocalizations.of(context).removeCoupon,
        ),
        body: CouponView(onPress: onPress, id: id),
      ),
    );
  }
}

class CouponView extends StatelessWidget {
  const CouponView({Key? key, this.onPress, this.id}) : super(key: key);

  final Function(String id)? onPress;
  final String? id;

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      context.read<CouponBloc>().add(FetchData());
    });
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
                  child: Stack(
                    children: [
                      TicketWidget(
                        onPress: onPress != null
                            ? () => onPress!(state.listCoupon[index].id)
                            : () {
                                Navigator.of(context).push(createRoute(
                                  screen: ViewSpecialOfferPage(
                                      coupon: state.listCoupon[index]),
                                  begin: const Offset(0, 1),
                                ));
                              },
                        title: state.listCoupon[index].couponName,
                        image: state.listCoupon[index].imageUrl.toString(),
                        content: state.listCoupon[index].content,
                        date: state.listCoupon[index].dueDate,
                      ),
                      if (id == state.listCoupon[index].id)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                            child: Text(
                              AppLocalizations.of(context).currentSelection,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                    ],
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
}
