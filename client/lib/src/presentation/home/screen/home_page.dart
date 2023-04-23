import 'package:coffee/src/core/function/custom_toast.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/presentation/home/bloc/home_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/constants/constants.dart';
import '../../activity/widgets/custom_app_bar.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';
import '../widgets/build_selling_products.dart';
import '../widgets/build_special_offer.dart';
import '../widgets/description_line.dart';
import '../widgets/membership_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc()..add(FetchData()),
      child: const Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: CustomAppBar(elevation: 0, isPick: false, title: ""),
        body: HomeView(),
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeError) {
          customToast(context, state.message.toString());
        }
      },
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<HomeBloc>().add(FetchData());
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const MembershipCard(),
              const SizedBox(height: 30),
              descriptionLine(
                text: "promotion".translate(context),
                color: AppColors.textColor,
              ),
              const SizedBox(height: 10),
              const BuildListSpecialOffer(),
              const SizedBox(height: 20),
              descriptionLine(
                text: "Sản phẩm gợi ý",
                color: AppColors.textColor,
              ),
              const SizedBox(height: 10),
              const BuildListSellingProducts(),
              const SizedBox(height: 10),
              // const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
