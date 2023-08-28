import 'package:coffee_admin/src/data/models/user.dart';

import '../../../data/remote/response/order/order_response.dart';

class GetOrderResponse {
  final User user;
  final OrderResponse order;

  GetOrderResponse({required this.user, required this.order});
}
