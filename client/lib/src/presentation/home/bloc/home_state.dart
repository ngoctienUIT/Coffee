import 'package:coffee/src/data/remote/response/coupon/coupon_response.dart';
import 'package:coffee/src/data/remote/response/product/product_response.dart';

import '../../../data/models/user.dart';
import '../../../data/remote/response/order/order_response.dart';
import '../../../data/remote/response/weather/weather_response.dart';

abstract class HomeState {}

class InitState extends HomeState {}

class ChangeBannerState extends HomeState {}

class HomeLoading extends HomeState {
  bool check;

  HomeLoading(this.check);
}

class HomeLoaded extends HomeState {
  final List<ProductResponse> listProduct;
  final WeatherResponse? weather;
  final String? address;
  final User user;

  HomeLoaded({
    required this.user,
    this.listProduct = const [],
    this.weather,
    this.address,
  });
}

class CouponLoaded extends HomeState {
  final List<CouponResponse> listCoupon;

  CouponLoaded({this.listCoupon = const []});
}

class WeatherLoaded extends HomeState {
  final WeatherResponse? weather;
  final String? address;
  final User user;

  WeatherLoaded({this.weather, this.address, required this.user});
}

class HomeError extends HomeState {
  final String? message;
  HomeError(this.message);
}

class CartLoaded extends HomeState {
  final OrderResponse? order;

  CartLoaded(this.order);
}
