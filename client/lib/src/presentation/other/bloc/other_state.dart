import 'package:equatable/equatable.dart';

abstract class OtherState extends Equatable {}

class InitState extends OtherState {
  @override
  List<Object?> get props => [];
}

class ChangeLanguageState extends OtherState {
  final int language;

  ChangeLanguageState({required this.language});

  @override
  List<Object?> get props => [language];
}
