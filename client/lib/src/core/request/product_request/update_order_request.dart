import '../../../data/models/order.dart';
import '../../../data/models/product.dart';

class UpdateOrderRequest {
  final Order order;
  final Product product;

  UpdateOrderRequest({required this.order, required this.product});
}
