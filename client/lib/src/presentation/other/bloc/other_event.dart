abstract class OtherEvent {}

class ChangeLanguageEvent extends OtherEvent {
  final int language;

  ChangeLanguageEvent({required this.language});
}
