import 'package:equatable/equatable.dart';

abstract class AddProductCataloguesState extends Equatable {}

class InitState extends AddProductCataloguesState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class SaveButtonState extends AddProductCataloguesState {
  final bool isContinue;

  SaveButtonState(this.isContinue);

  @override
  List<Object?> get props => [isContinue];
}

class ChangeImageState extends AddProductCataloguesState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class AddProductCataloguesLoadingState extends AddProductCataloguesState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class AddProductCataloguesSuccessState extends AddProductCataloguesState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class AddProductCataloguesErrorState extends AddProductCataloguesState {
  final String status;

  AddProductCataloguesErrorState(this.status);

  @override
  List<Object?> get props => [status];
}
