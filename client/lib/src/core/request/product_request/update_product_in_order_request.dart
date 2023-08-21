import '../../../data/models/order.dart';
import '../../../data/models/product.dart';

class UpdateProductInOrderRequest {
  final int index;
  final Product product;
  final Order order;

  UpdateProductInOrderRequest({
    required this.index,
    required this.product,
    required this.order,
  });
}
