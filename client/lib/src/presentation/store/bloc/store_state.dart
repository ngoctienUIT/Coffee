import 'package:coffee/src/data/models/store.dart';
import 'package:equatable/equatable.dart';

abstract class StoreState extends Equatable {}

class InitState extends StoreState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class StoreLoading extends StoreState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class StoreLoaded extends StoreState {
  final List<Store> listStore;
  final String id;

  StoreLoaded(this.listStore, this.id);

  @override
  List<Object?> get props => [listStore, id];
}

class StoreError extends StoreState {
  final String? message;

  StoreError(this.message);

  @override
  List<Object?> get props => [message];
}
