import 'dart:async';

import 'package:coffee/injection.dart';
import 'package:coffee/src/core/function/custom_toast.dart';
import 'package:coffee/src/core/services/bloc/service_bloc.dart';
import 'package:coffee/src/core/services/bloc/service_event.dart';
import 'package:coffee/src/core/services/bloc/service_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:coffee/src/data/models/order.dart';
import 'package:coffee/src/presentation/home/bloc/home_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../activity/widgets/custom_app_bar.dart';
import '../../cart/screen/cart_page.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';
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
      create: (context) => getIt<HomeBloc>()
        ..add(FetchData())
        ..add(GetOrderSpendingEvent())
        ..add(GetCouponEvent()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  late StreamSubscription<ServiceStatus> serviceStatusStream;
  late PageController pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;
  late Timer _timer;
  List<String> listBanner = [
    "assets/banner/banner1.png",
    "assets/banner/banner2.jpg",
    "assets/banner/banner3.png",
    "assets/banner/banner4.jpg",
    "assets/banner/banner5.png",
  ];

  @override
  void initState() {
    serviceStatusStream =
        Geolocator.getServiceStatusStream().listen((ServiceStatus status) {
      if (status == ServiceStatus.enabled) {
        context.read<HomeBloc>().add(FetchData(check: false));
      }
    });
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 4) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    serviceStatusStream.cancel();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: const CustomAppBar(elevation: 0, isPick: false, title: ""),
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeError) {
            customToast(context, state.message.toString());
          }
          if (state is CartLoaded) {
            context.read<ServiceBloc>().add(ChangeOrderEvent(
                  state.order != null
                      ? Order.fromOrderResponse(state.order!)
                      : null,
                ));
          }
        },
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<HomeBloc>().add(FetchData(check: false));
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const MembershipCard(),
                const SizedBox(height: 30),
                descriptionLine(
                  text: AppLocalizations.of(context).promotion,
                  color: AppColors.textColor,
                ),
                const SizedBox(height: 10),
                const BuildListSpecialOffer(),
                const SizedBox(height: 20),
                buildBanner(),
                const SizedBox(height: 20),
                descriptionLine(
                  text: AppLocalizations.of(context).recommendedProducts,
                  color: AppColors.textColor,
                ),
                const SizedBox(height: 10),
                const BuildListSellingProducts(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.statusBarColor,
        onPressed: () {
          Navigator.of(context).push(createRoute(
            screen: const CartPage(),
            begin: const Offset(1, 0),
          ));
        },
        child: BlocBuilder<ServiceBloc, ServiceState>(
          buildWhen: (previous, current) =>
              current is ChangeOrderState || current is ChangeStoreState,
          builder: (context, state) {
            Order? order = getIt.isRegistered<Order>() ? getIt<Order>() : null;
            return cartNumber(order?.orderItems.length ?? 0);
            // return cartNumber(0);
          },
        ),
      ),
    );
  }

  Widget buildBanner() {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          current is ChangeBannerState && current is! HomeError,
      builder: (context, state) {
        return SizedBox(
          height: 150,
          child: PageView.builder(
            physics: const BouncingScrollPhysics(),
            controller: pageController,
            itemCount: listBanner.length,
            onPageChanged: (value) {
              _currentPage = value;
              context.read<HomeBloc>().add(ChangeBannerEvent());
            },
            itemBuilder: (context, index) {
              double scale = _currentPage == index ? 1 : 0.9;
              return TweenAnimationBuilder(
                tween: Tween(begin: scale, end: scale),
                builder: (context, value, child) {
                  return Transform.scale(scale: value, child: child);
                },
                duration: const Duration(milliseconds: 350),
                child: Image.asset(listBanner[index]),
              );
            },
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
