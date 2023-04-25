import 'package:coffee_admin/src/data/models/recommend.dart';

abstract class AddRecommendEvent {}

class ChangeTagEvent extends AddRecommendEvent {}

class ChangeWeatherEvent extends AddRecommendEvent {}

class SaveButtonEvent extends AddRecommendEvent {
  bool isContinue;

  SaveButtonEvent(this.isContinue);
}

class CreateRecommendEvent extends AddRecommendEvent {
  Recommend recommend;

  CreateRecommendEvent(this.recommend);
}

class UpdateRecommendEvent extends AddRecommendEvent {
  Recommend recommend;

  UpdateRecommendEvent(this.recommend);
}
