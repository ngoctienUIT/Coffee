import 'package:coffee/src/core/utils/extensions/string_extension.dart';

import '../../../data/remote/response/coupon/coupon_response.dart';
import '../../../data/remote/response/order/order_response.dart';

extension ListOrderExtension on List<OrderResponse> {
  List<OrderResponse> filterCompleteOrCancel() {
    return where((element) =>
        element.orderStatus == "COMPLETED" ||
        element.orderStatus == "CANCELLED").toList();
  }

  void sortByTime() {
    sort((a, b) => b.createdDate!
        .toDateTime2()
        .difference(a.createdDate!.toDateTime2())
        .inSeconds);
  }
}

extension ListCouponExtension on List<CouponResponse> {
  List<CouponResponse> filterCoupon() {
    return where((element) =>
            element.dueDate.toDate().difference(DateTime.now()).inSeconds >= 0)
        .toList();
  }
}
