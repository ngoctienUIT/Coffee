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

class UpdateLoadingState extends ProductState {}

class UpdateSuccessState extends ProductState {}

class UpdateErrorState extends ProductState {
  String error;

  UpdateErrorState(this.error);
}

class DeleteLoadingState extends ProductState {}

class DeleteSuccessState extends ProductState {}

class DeleteErrorState extends ProductState {
  String error;

  DeleteErrorState(this.error);
}
