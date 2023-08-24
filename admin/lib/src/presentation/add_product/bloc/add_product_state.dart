import 'package:equatable/equatable.dart';

abstract class AddProductState extends Equatable {}

class InitState extends AddProductState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ChangeImageState extends AddProductState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ChangeToppingState extends AddProductState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ChangeTagState extends AddProductState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ChangeCatalogueState extends AddProductState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class SaveButtonState extends AddProductState {
  final bool isContinue;

  SaveButtonState(this.isContinue);

  @override
  List<Object?> get props => [isContinue];
}

class AddProductLoadingState extends AddProductState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class AddProductSuccessState extends AddProductState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class AddProductErrorState extends AddProductState {
  final String status;

  AddProductErrorState(this.status);

  @override
  List<Object?> get props => [status];
}
