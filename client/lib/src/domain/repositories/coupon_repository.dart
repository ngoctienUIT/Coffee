import 'package:coffee/src/core/resources/data_state.dart';

import '../../data/remote/response/coupon/coupon_response.dart';

abstract class CouponRepository {
  Future<DataState<List<CouponResponse>>> getData();
}
