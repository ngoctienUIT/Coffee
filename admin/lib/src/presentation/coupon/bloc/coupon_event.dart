import 'package:equatable/equatable.dart';

abstract class CouponEvent extends Equatable {}

class FetchData extends CouponEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class UpdateData extends CouponEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class DeleteEvent extends CouponEvent {
  final String id;

  DeleteEvent(this.id);

  @override
  List<Object?> get props => [id];
}
