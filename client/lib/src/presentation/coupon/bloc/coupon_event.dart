import 'package:equatable/equatable.dart';

abstract class CouponEvent extends Equatable {}

class FetchData extends CouponEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}
