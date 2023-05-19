abstract class OtherState {}

class InitState extends OtherState {}

class ChangeLanguageState extends OtherState {
  final int language;

  ChangeLanguageState({required this.language});
}
