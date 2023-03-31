abstract class OtherEvent {}

class FetchData extends OtherEvent {}

class ChangeLanguageEvent extends OtherEvent {
  final int language;

  ChangeLanguageEvent({required this.language});
}
