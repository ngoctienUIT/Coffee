import 'package:equatable/equatable.dart';

import '../../../data/models/store.dart';

abstract class AddStoreEvent extends Equatable {}

class CreateStoreEvent extends AddStoreEvent {
  final Store store;

  CreateStoreEvent(this.store);

  @override
  List<Object?> get props => [store];
}

class ChangeImageEvent extends AddStoreEvent {
  final String image;

  ChangeImageEvent(this.image);

  @override
  List<Object?> get props => [image];
}

class SaveButtonEvent extends AddStoreEvent {
  final bool isContinue;

  SaveButtonEvent(this.isContinue);

  @override
  List<Object?> get props => [isContinue];
}

class UpdateStoreEvent extends AddStoreEvent {
  final Store store;

  UpdateStoreEvent(this.store);

  @override
  List<Object?> get props => [store];
}

class ChangeAddressEvent extends AddStoreEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ChangeOpenEvent extends AddStoreEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ChangeCloseEvent extends AddStoreEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}
