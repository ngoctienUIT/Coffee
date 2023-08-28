import 'package:coffee/src/data/remote/response/coupon/coupon_response.dart';
import 'package:coffee/src/data/remote/response/product/product_response.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/user.dart';
import '../../../data/remote/response/order/order_response.dart';
import '../../../data/remote/response/weather/weather_response.dart';

abstract class HomeState extends Equatable {}

class InitState extends HomeState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ChangeBannerState extends HomeState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class HomeLoading extends HomeState {
  final bool check;

  HomeLoading(this.check);

  @override
  List<Object?> get props => [check];
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

  @override
  List<Object?> get props => [listProduct, weather, address, user];
}

class CouponLoaded extends HomeState {
  final List<CouponResponse> listCoupon;

  CouponLoaded({this.listCoupon = const []});

  @override
  List<Object?> get props => [listCoupon];
}

class WeatherLoaded extends HomeState {
  final WeatherResponse? weather;
  final String? address;
  final User user;

  WeatherLoaded({this.weather, this.address, required this.user});

  @override
  List<Object?> get props => [weather, address, user];
}

class HomeError extends HomeState {
  final String? message;

  HomeError(this.message);

  @override
  List<Object?> get props => [message];
}

class CartLoaded extends HomeState {
  final OrderResponse? order;

  CartLoaded(this.order);

  @override
  List<Object?> get props => [order];
}
