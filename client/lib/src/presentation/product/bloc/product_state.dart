import '../../../data/models/product.dart';

abstract class ProductState {}

class InitState extends ProductState {}

class DataTransmissionState extends ProductState {
  final Product product;

  DataTransmissionState(this.product);
}
