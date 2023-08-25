import 'package:coffee_admin/src/data/local/entity/store_entity.dart';
import 'package:equatable/equatable.dart';

abstract class StoreState extends Equatable {}

class InitState extends StoreState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class DeleteSuccess extends StoreState {
  final String id;

  DeleteSuccess(this.id);

  @override
  List<Object?> get props => [id];
}

class StoreLoading extends StoreState {
  final bool check;

  StoreLoading([this.check = true]);

  @override
  List<Object?> get props => [check];
}

class StoreLoaded extends StoreState {
  final List<StoreEntity> listStore;

  StoreLoaded(this.listStore);

  @override
  List<Object?> get props => [listStore];
}

class StoreError extends StoreState {
  final String? message;

  StoreError(this.message);

  @override
  List<Object?> get props => [message];
}
