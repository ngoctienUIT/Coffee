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

class LogOutState extends ServiceState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}
