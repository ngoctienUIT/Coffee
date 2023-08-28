import 'package:equatable/equatable.dart';

abstract class SettingEvent extends Equatable {}

class DeleteAccountEvent extends SettingEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}
