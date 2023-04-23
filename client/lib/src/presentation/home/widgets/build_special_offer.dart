import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee/src/presentation/store/widgets/item_loading.dart';
import 'package:coffee/src/presentation/view_special_offer/screen/view_special_offer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/route_function.dart';
import '../../../domain/repositories/coupon/coupon_response.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';

class BuildListSpecialOffer extends StatelessWidget {
  const BuildListSpecialOffer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          current is CouponLoaded ||
          current is HomeLoading ||
          current is InitState,
      builder: (context, state) {
        if (state is CouponLoaded) {
          return SizedBox(
            height: 250,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: state.listCoupon.length,
              itemBuilder: (context, index) {
                return InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    Navigator.of(context).push(createRoute(
                      screen:
                          ViewSpecialOfferPage(coupon: state.listCoupon[index]),
                      begin: const Offset(0, 1),
                    ));
                  },
                  child: buildSpecialOffer(state.listCoupon[index]),
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
    Random rng = Random();
    return SizedBox(
      height: 250,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(5),
            child: Card(
              child: SizedBox(
                width: 170,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      itemLoading(150, 150, 0),
                      const Spacer(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: itemLoading(20, rng.nextDouble() * 50 + 110, 10),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: itemLoading(15, rng.nextDouble() * 50 + 100, 10),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSpecialOffer(CouponResponse coupon) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Card(
        child: SizedBox(
          width: 170,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                CachedNetworkImage(
                  height: 150,
                  width: 150,
                  imageUrl: coupon.imageUrl ?? "",
                  placeholder: (context, url) => itemLoading(150, 150, 0),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    coupon.couponName,
                    maxLines: 2,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    coupon.dueDate,
                    style: const TextStyle(color: Color(0xFF7A7A7A)),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
