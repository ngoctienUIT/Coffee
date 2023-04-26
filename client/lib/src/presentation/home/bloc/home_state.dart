import 'package:coffee/src/domain/entities/user/user_response.dart';
import 'package:coffee/src/domain/repositories/coupon/coupon_response.dart';
import 'package:coffee/src/domain/repositories/product/product_response.dart';

import '../../../domain/repositories/order/order_response.dart';
import '../../../domain/repositories/weather/weather_response.dart';

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
  final UserResponse user;

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
  final UserResponse user;

  WeatherLoaded({this.weather, this.address, required this.user});
}

class HomeError extends HomeState {
  final String? message;
  HomeError(this.message);
}

class AddProductToCartLoaded extends HomeState {
  final OrderResponse? order;

  AddProductToCartLoaded(this.order);
}
