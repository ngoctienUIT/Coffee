import '../../../data/models/order.dart';

abstract class ProductState {
  Order? order;

  ProductState([this.order]);
}

class InitState extends ProductState {}

class DataTransmissionState extends ProductState {}

class ProductLoadingState extends ProductState {}

class AddProductToOrderSuccessState extends ProductState {
  AddProductToOrderSuccessState([super.order]);
}

class UpdateSuccessState extends ProductState {
  UpdateSuccessState([super.order]);
}

class DeleteSuccessState extends ProductState {
  DeleteSuccessState([super.order]);
}

class ProductErrorState extends ProductState {
  String error;

  ProductErrorState(this.error);
}
