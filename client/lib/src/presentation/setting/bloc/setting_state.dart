import 'package:equatable/equatable.dart';

abstract class SettingState extends Equatable {}

class InitState extends SettingState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class DeleteLoadingState extends SettingState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class DeleteSuccessState extends SettingState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class DeleteErrorState extends SettingState {
  final String error;

  DeleteErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
