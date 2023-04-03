import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/presentation/home/bloc/home_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../activity/widgets/custom_app_bar.dart';
import '../../cart/screen/cart_page.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';
import '../widgets/build_item_product.dart';
import '../widgets/build_selling_products.dart';
import '../widgets/build_special_offer.dart';
import '../widgets/cart_number.dart';
import '../widgets/description_line.dart';
import '../widgets/membership_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc()..add(FetchData()),
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: const CustomAppBar(isPick: false),
        body: const HomeView(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(createRoute(
              screen: const CartPage(),
              begin: const Offset(1, 0),
            ));
          },
          backgroundColor: AppColors.statusBarColor,
          child: cartNumber(1),
        ),
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<HomeBloc>().add(FetchData());
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const MembershipCard(),
            const SizedBox(height: 10),
            const BuildListItemProduct(),
            const SizedBox(height: 20),
            descriptionLine(
              text: "promotion".translate(context),
              color: AppColors.textColor,
            ),
            buildListSpecialOffer(),
            const SizedBox(height: 20),
            descriptionLine(
              text: "selling_products".translate(context),
              color: AppColors.textColor,
            ),
            buildListSellingProducts(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget buildListSpecialOffer() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is InitState || state is HomeLoading) {
          return _buildLoading();
        }
        if (state is HomeError) {
          return Center(child: Text(state.message!));
        }
        if (state is HomeLoaded) {
          return BuildListSpecialOffer(listCoupon: state.listCoupon);
        }
        return Container();
      },
    );
  }

  Widget buildListSellingProducts() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is InitState || state is HomeLoading) {
          return _buildLoading();
        }
        if (state is HomeError) {
          return Center(child: Text(state.message!));
        }
        if (state is HomeLoaded) {
          return BuildListSellingProducts(listProduct: state.listProduct);
        }
        return Container();
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
