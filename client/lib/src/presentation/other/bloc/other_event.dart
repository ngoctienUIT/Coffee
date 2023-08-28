import 'package:equatable/equatable.dart';

abstract class OtherEvent extends Equatable {}

class ChangeLanguageEvent extends OtherEvent {
  final int language;

  ChangeLanguageEvent({required this.language});

  @override
  List<Object?> get props => [language];
}
