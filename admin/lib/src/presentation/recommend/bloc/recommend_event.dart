import 'package:equatable/equatable.dart';

abstract class RecommendEvent extends Equatable {}

class FetchData extends RecommendEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class UpdateData extends RecommendEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class DeleteEvent extends RecommendEvent {
  final String id;

  DeleteEvent(this.id);

  @override
  List<Object?> get props => [id];
}
