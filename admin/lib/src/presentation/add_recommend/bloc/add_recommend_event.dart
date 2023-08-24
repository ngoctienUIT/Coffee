import 'package:coffee_admin/src/data/models/recommend.dart';
import 'package:equatable/equatable.dart';

abstract class AddRecommendEvent extends Equatable {}

class ChangeTagEvent extends AddRecommendEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ChangeWeatherEvent extends AddRecommendEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class SaveButtonEvent extends AddRecommendEvent {
  final bool isContinue;

  SaveButtonEvent(this.isContinue);

  @override
  List<Object?> get props => [isContinue];
}

class CreateRecommendEvent extends AddRecommendEvent {
  final Recommend recommend;

  CreateRecommendEvent(this.recommend);

  @override
  List<Object?> get props => [recommend];
}

class UpdateRecommendEvent extends AddRecommendEvent {
  final Recommend recommend;

  UpdateRecommendEvent(this.recommend);

  @override
  List<Object?> get props => [recommend];
}
