import 'package:equatable/equatable.dart';

import '../../../data/models/order.dart';

abstract class ProductState extends Equatable {
  final Order? order;

  const ProductState([this.order]);
}

class InitState extends ProductState {
  @override
  List<Object?> get props => [];
}

class DataTransmissionState extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductLoadingState extends ProductState {
  @override
  List<Object?> get props => [];
}

class AddProductToOrderSuccessState extends ProductState {
  const AddProductToOrderSuccessState([super.order]);

  @override
  List<Object?> get props => [super.order];
}

class UpdateSuccessState extends ProductState {
  const UpdateSuccessState([super.order]);

  @override
  List<Object?> get props => [super.order];
}

class DeleteSuccessState extends ProductState {
  const DeleteSuccessState([super.order]);

  @override
  List<Object?> get props => [super.order];
}

class ProductErrorState extends ProductState {
  final String error;

  const ProductErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
