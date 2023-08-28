import 'package:coffee/src/data/remote/response/coupon/coupon_response.dart';
import 'package:geolocator/geolocator.dart';

import '../../core/resources/data_state.dart';
import '../../core/resources/request_state.dart';
import '../../core/response/home_response/recommend_response.dart';
import '../../data/remote/response/order/order_response.dart';

abstract class HomeRepository {
  Future<DataState<RecommendResponse>> getRecommend(RequestState<Position?> result);

  Future<DataState<List<CouponResponse>>> getCoupon();

  Future<DataState<OrderResponse?>> getOrderSpending();
}
