import '../../../data/models/product.dart';

abstract class ViewProductState {}

class InitState extends ViewProductState {}

class DataTransmissionState extends ViewProductState {
  final Product product;

  DataTransmissionState(this.product);
}
