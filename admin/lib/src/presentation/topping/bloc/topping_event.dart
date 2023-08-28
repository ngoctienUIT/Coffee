import 'package:equatable/equatable.dart';

abstract class ToppingEvent extends Equatable {}

class FetchData extends ToppingEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class UpdateData extends ToppingEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class PickEvent extends ToppingEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class DeleteEvent extends ToppingEvent {
  final String id;

  DeleteEvent(this.id);

  @override
  List<Object?> get props => [id];
}
