import 'package:equatable/equatable.dart';

abstract class AddToppingState extends Equatable {}

class InitState extends AddToppingState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class SaveButtonState extends AddToppingState {
  final bool isContinue;

  SaveButtonState(this.isContinue);

  @override
  List<Object?> get props => [isContinue];
}

class ChangeImageState extends AddToppingState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class AddToppingLoadingState extends AddToppingState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class AddToppingSuccessState extends AddToppingState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class AddToppingErrorState extends AddToppingState {
  final String status;

  AddToppingErrorState(this.status);

  @override
  List<Object?> get props => [identityHashCode(this)];
}
