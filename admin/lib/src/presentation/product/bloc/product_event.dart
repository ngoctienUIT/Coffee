import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {}

class FetchData extends ProductEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class DeleteEvent extends ProductEvent {
  final int index;
  final String id;

  DeleteEvent(this.index, this.id);

  @override
  List<Object?> get props => [index, id];
}

class RefreshData extends ProductEvent {
  final int index;

  RefreshData(this.index);

  @override
  List<Object?> get props => [index];
}

class UpdateData extends ProductEvent {
  final int index;

  UpdateData(this.index);

  @override
  List<Object?> get props => [index];
}
