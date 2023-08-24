import 'package:equatable/equatable.dart';

abstract class TagEvent extends Equatable {}

class FetchData extends TagEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class UpdateData extends TagEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class DeleteEvent extends TagEvent {
  final String id;

  DeleteEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class PickEvent extends TagEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}
