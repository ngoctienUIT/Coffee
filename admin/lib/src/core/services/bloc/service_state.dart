import 'package:equatable/equatable.dart';

abstract class ServiceState extends Equatable {}

class InitServiceState extends ServiceState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ChangeUserInfoState extends ServiceState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ChangeOrderState extends ServiceState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ChangeStoreState extends ServiceState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class PlacedOrderState extends ServiceState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class LogOutState extends ServiceState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}
