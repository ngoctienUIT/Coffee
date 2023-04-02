import '../../../data/models/product.dart';

abstract class ProductState {}

class InitState extends ProductState {}

class DataTransmissionState extends ProductState {
  final Product product;

  DataTransmissionState(this.product);
}

class AddProductToOrderSuccessState extends ProductState {}

class AddProductToOrderErrorState extends ProductState {
  String error;

  AddProductToOrderErrorState(this.error);
}

class AddProductToOrderLoadingState extends ProductState {}
