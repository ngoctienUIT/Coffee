import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable {}

class FetchData extends OrderEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class RefreshData extends OrderEvent {
  final int index;

  RefreshData(this.index);

  @override
  List<Object?> get props => [index];
}
