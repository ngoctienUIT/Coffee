import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable {}

class FetchData extends OrderEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class UpdateData extends OrderEvent {
  final int index;

  UpdateData(this.index);

  @override
  List<Object?> get props => [index];
}

class RefreshData extends OrderEvent {
  final int index;

  RefreshData(this.index);

  @override
  List<Object?> get props => [index];
}

class ChangeOrderListEvent extends OrderEvent {
  final String id;

  ChangeOrderListEvent(this.id);

  @override
  List<Object?> get props => [id];
}
