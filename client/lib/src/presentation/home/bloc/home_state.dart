import 'package:coffee/src/domain/repositories/coupon/coupon_response.dart';
import 'package:coffee/src/domain/repositories/product/product_response.dart';

abstract class HomeState {}

class InitState extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<ProductResponse> listProduct;
  final List<CouponResponse> listCoupon;
  HomeLoaded({required this.listProduct, required this.listCoupon});
}

class HomeError extends HomeState {
  final String? message;
  HomeError(this.message);
}
