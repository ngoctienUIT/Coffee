import 'package:equatable/equatable.dart';

abstract class AccountEvent extends Equatable {}

class FetchData extends AccountEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class UpdateData extends AccountEvent {
  final int index;

  UpdateData(this.index);

  @override
  List<Object?> get props => [index];
}

class DeleteEvent extends AccountEvent {
  final String id;
  final int index;

  DeleteEvent(this.id, this.index);

  @override
  List<Object?> get props => [id, index];
}

class RefreshData extends AccountEvent {
  final int index;

  RefreshData(this.index);

  @override
  List<Object?> get props => [index];
}
