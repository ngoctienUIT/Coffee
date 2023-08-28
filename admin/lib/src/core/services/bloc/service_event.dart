import 'package:equatable/equatable.dart';

import '../../../data/models/user.dart';

abstract class ServiceEvent extends Equatable {}

class ChangeUserInfoEvent extends ServiceEvent {
  final User user;

  ChangeUserInfoEvent(this.user);

  @override
  List<Object?> get props => [user];
}

class CheckLoginEvent extends ServiceEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class StopTimeEvent extends ServiceEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class SaveTimeEvent extends ServiceEvent {
  final Duration duration;

  SaveTimeEvent(this.duration);

  @override
  List<Object?> get props => [identityHashCode(this)];
}
