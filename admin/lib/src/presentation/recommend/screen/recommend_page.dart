import 'dart:math';

import 'package:coffee_admin/src/core/function/loading_animation.dart';
import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:coffee_admin/src/domain/repositories/recommend/recommend_response.dart';
import 'package:coffee_admin/src/presentation/add_recommend/screen/add_recommend_page.dart';
import 'package:coffee_admin/src/presentation/recommend/bloc/recommend_bloc.dart';
import 'package:coffee_admin/src/presentation/recommend/bloc/recommend_event.dart';
import 'package:coffee_admin/src/presentation/recommend/bloc/recommend_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/function/route_function.dart';
import '../../../core/services/bloc/service_bloc.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../core/widgets/custom_alert_dialog.dart';
import '../../../data/models/preferences_model.dart';
import '../../forgot_password/widgets/app_bar_general.dart';
import '../../order/widgets/item_loading.dart';

class RecommendPage extends StatelessWidget {
  const RecommendPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PreferencesModel preferencesModel =
        context.read<ServiceBloc>().preferencesModel;
    return BlocProvider(
      create: (context) => RecommendBloc(preferencesModel)..add(FetchData()),
      child: const RecommendView(),
    );
  }
}

class RecommendView extends StatelessWidget {
  const RecommendView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PreferencesModel preferencesModel =
        context.read<ServiceBloc>().preferencesModel;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar:
          AppBarGeneral(title: "recommend".translate(context), elevation: 0),
      body: SafeArea(child: bodyRecommend()),
      floatingActionButton: preferencesModel.user!.userRole == "ADMIN"
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(createRoute(
                  screen: AddRecommendPage(
                    onChange: () =>
                        context.read<RecommendBloc>().add(UpdateData()),
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

  Widget bodyRecommend() {
    List<RecommendResponse> listRecommend = [];
    return BlocConsumer<RecommendBloc, RecommendState>(
      listener: (context, state) {
        if (state is RecommendError) {
          customToast(context, state.error.toString());
        }
        if (state is RecommendLoading && !state.check) {
          loadingAnimation(context);
        }
        if (state is DeleteSuccess) {
          Navigator.pop(context);
        }
      },
      buildWhen: (previous, current) =>
          !(current is RecommendLoading && !current.check),
      builder: (context, state) {
        if (state is RecommendLoaded || state is DeleteSuccess) {
          if (state is RecommendLoaded) {
            listRecommend = [];
            listRecommend.addAll(state.listRecommend);
          }
          if (state is DeleteSuccess) {
            listRecommend.removeWhere((element) => element.id == state.id);
          }
          return RefreshIndicator(
            onRefresh: () async {
              context.read<RecommendBloc>().add(FetchData());
            },
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 70),
              itemCount: listRecommend.length,
              itemBuilder: (context, index) {
                return Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio: 0.35,
                    children: [
                      SlidableAction(
                        onPressed: (_) {
                          Navigator.of(context).push(createRoute(
                            screen: AddRecommendPage(
                              recommend: listRecommend[index],
                              onChange: () {
                                context.read<RecommendBloc>().add(UpdateData());
                              },
                            ),
                            begin: const Offset(0, 1),
                          ));
                        },
                        backgroundColor: AppColors.statusBarColor,
                        foregroundColor: const Color.fromRGBO(231, 231, 231, 1),
                        icon: FontAwesomeIcons.penToSquare,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      SlidableAction(
                        onPressed: (_) {
                          _showAlertDialog(context, () {
                            context
                                .read<RecommendBloc>()
                                .add(DeleteEvent(listRecommend[index].id!));
                          });
                        },
                        backgroundColor: AppColors.statusBarColor,
                        foregroundColor: const Color.fromRGBO(231, 231, 231, 1),
                        icon: FontAwesomeIcons.trash,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ],
                  ),
                  child: itemRecommend(context, listRecommend[index]),
                );
              },
            ),
          );
        }
        return _buildLoading();
      },
    );
  }

  Widget itemRecommend(BuildContext context, RecommendResponse recommend) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  getIconWeather(
                      recommend.weather == null ? "" : recommend.weather!),
                  width: 30,
                ),
                const SizedBox(width: 10),
                Text(
                  recommend.weather == null ? "" : recommend.weather!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            if (recommend.minTemp != null) const SizedBox(height: 10),
            if (recommend.minTemp != null)
              Text(
                "${"lowest_temperature".translate(context)}: ${recommend.minTemp.toString().split(".0").first}°C",
                style: const TextStyle(fontSize: 16),
              ),
            if (recommend.maxTemp != null) const SizedBox(height: 10),
            if (recommend.maxTemp != null)
              Text(
                "${"maximum_temperature".translate(context)}: ${recommend.maxTemp.toString().split(".0").first}°C",
                style: const TextStyle(fontSize: 16),
              ),
            if (recommend.tags != null && recommend.tags!.isNotEmpty)
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: recommend.tags!.length,
                itemBuilder: (context, index) {
                  String color =
                      "FF${recommend.tags![index].tagColorCode!.split("#").last}";
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(int.parse(color, radix: 16)),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Text(
                        "${recommend.tags![index].tagName!} - ${recommend.tags![index].tagColorCode!}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              )
          ],
        ),
      ),
    );
  }

  String getIconWeather(String weather) {
    switch (weather) {
      case "CLOUDS":
        return AppImages.imgClouds;
      case "RAIN":
        return AppImages.imgRain;
      case "SNOW":
        return AppImages.imgSnow;
      default:
        return AppImages.imgClear;
    }
  }

  String getIconWeatherLoading(int index) {
    switch (index) {
      case 0:
        return AppImages.imgClouds;
      case 1:
        return AppImages.imgRain;
      case 2:
        return AppImages.imgSnow;
      default:
        return AppImages.imgClear;
    }
  }

  Widget _buildLoading() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      physics: const BouncingScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return itemRecommendLoading();
      },
    );
  }

  Widget itemRecommendLoading() {
    var rng = Random();
    bool checkMin = rng.nextBool();
    bool checkMax = rng.nextBool();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Image.asset(
                    getIconWeatherLoading(rng.nextInt(4)),
                    width: 30,
                  ),
                ),
                const SizedBox(width: 10),
                itemLoading(20, rng.nextDouble() * 30 + 65, 10),
              ],
            ),
            if (checkMin) const SizedBox(height: 10),
            if (checkMin) itemLoading(15, rng.nextDouble() * 50 + 150, 10),
            if (checkMax) const SizedBox(height: 10),
            if (checkMax) itemLoading(15, rng.nextDouble() * 50 + 150, 10),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 5),
              shrinkWrap: true,
              itemCount: rng.nextInt(4) + 2,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: itemLoading(25, double.infinity, 20),
                );
              },
            )
          ],
        ),
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
          title: 'remove_recommend'.translate(context),
          content: 'are_you_sure_you_want_to_delete_this_recommend'
              .translate(context),
          onOK: onOK,
        );
      },
    );
  }
}
