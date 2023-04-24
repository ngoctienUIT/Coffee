abstract class AddRecommendEvent {}

class ChangeTagEvent extends AddRecommendEvent {}

class ChangeWeatherEvent extends AddRecommendEvent {}

class SaveButtonEvent extends AddRecommendEvent {
  bool isContinue;

  SaveButtonEvent(this.isContinue);
}
