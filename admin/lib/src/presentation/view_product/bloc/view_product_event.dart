import '../../../data/models/product.dart';

abstract class ViewProductEvent {}

class DataTransmissionEvent extends ViewProductEvent {
  final Product product;

  DataTransmissionEvent({required this.product});
}
