import 'package:equatable/equatable.dart';

abstract class AddStoreState extends Equatable {}

class InitState extends AddStoreState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ChangeImageState extends AddStoreState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ChangeAddressState extends AddStoreState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ChangeOpenState extends AddStoreState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ChangeCloseState extends AddStoreState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class SaveButtonState extends AddStoreState {
  final bool isContinue;

  SaveButtonState(this.isContinue);

  @override
  List<Object?> get props => [isContinue];
}

class AddStoreLoadingState extends AddStoreState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class AddStoreSuccessState extends AddStoreState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class AddStoreErrorState extends AddStoreState {
  final String status;

  AddStoreErrorState(this.status);

  @override
  List<Object?> get props => [identityHashCode(this)];
}
