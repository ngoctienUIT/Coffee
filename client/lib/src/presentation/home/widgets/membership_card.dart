import 'dart:math';

import 'package:coffee/injection.dart';
import 'package:coffee/src/core/services/bloc/service_bloc.dart';
import 'package:coffee/src/core/services/bloc/service_state.dart';
import 'package:coffee/src/core/utils/constants/app_colors.dart';
import 'package:coffee/src/core/utils/constants/app_images.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/data/models/user.dart';
import 'package:coffee/src/presentation/home/bloc/home_bloc.dart';
import 'package:coffee/src/presentation/home/bloc/home_state.dart';
import 'package:coffee/src/presentation/store/widgets/item_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class MembershipCard extends StatelessWidget {
  const MembershipCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          current is! ChangeBannerState &&
          current is! CouponLoaded &&
          current is! CartLoaded,
      builder: (context, state) {
        if (state is HomeLoaded) {
          return Container(
            height: 200,
            width: double.infinity,
            color: AppColors.bgCreamColor,
            padding: const EdgeInsets.all(10),
            child: Card(
              elevation: 0,
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage(AppImages.imgCard),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  // gradient: const LinearGradient(
                  //   colors: [
                  //     AppColors.statusBarColor,
                  //     Color.fromRGBO(233, 126, 136, 1),
                  //   ],
                  //   begin: Alignment.centerLeft,
                  //   end: Alignment.centerRight,
                  //   stops: [0.0, 1.0],
                  //   tileMode: TileMode.clamp,
                  // ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          getIconWeather(
                              state.weather == null ? "" : state.weather!.main),
                          width: 30,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          state.weather == null
                              ? "_ _ _ _ _ _"
                              : "${state.weather!.temperature.toStringAsFixed(1).split(".0").first}°C - ${state.weather!.main}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      state.address ??
                          "please_enable_location_accurate_product_recommendations_for_you"
                              .translate(context),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    BlocBuilder<ServiceBloc, ServiceState>(
                        buildWhen: (previous, current) =>
                            current is ChangeUserInfoState,
                        builder: (context, serviceState) {
                          String name = state.user.displayName;
                          if (serviceState is ChangeUserInfoState) {
                            name = getIt<User>().displayName;
                          }
                          return Text(
                            name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          );
                        }),
                    const Spacer(),
                    Text(
                      "member".translate(context),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return _buildLoading();
      },
    );
  }

  Widget _buildLoading() {
    Random rng = Random();
    return Container(
      height: 200,
      width: double.infinity,
      color: AppColors.bgCreamColor,
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage(AppImages.imgCard),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Image.asset(
                      AppImages.imgClouds,
                      height: 30,
                      width: 30,
                    ),
                  ),
                  const SizedBox(width: 10),
                  itemLoading(15, rng.nextDouble() * 30 + 90, 10),
                ],
              ),
              const Spacer(),
              itemLoading(18, double.infinity, 10),
              const SizedBox(height: 8),
              itemLoading(18, rng.nextDouble() * 50 + 100, 10),
              const Spacer(),
              itemLoading(18, rng.nextDouble() * 50 + 150, 10),
              const Spacer(),
              itemLoading(15, 110, 10),
            ],
          ),
        ),
      ),
    );
  }

  String getIconWeather(String weather) {
    switch (weather) {
      case "Clouds":
        return AppImages.imgClouds;
      case "Rain":
        return AppImages.imgRain;
      case "Snow":
        return AppImages.imgSnow;
      default:
        return AppImages.imgClear;
    }
  }
}
