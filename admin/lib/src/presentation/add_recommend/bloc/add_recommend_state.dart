import 'package:equatable/equatable.dart';

abstract class AddRecommendState extends Equatable {}

class InitState extends AddRecommendState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class AddRecommendLoading extends AddRecommendState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class AddRecommendSuccess extends AddRecommendState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class AddRecommendError extends AddRecommendState {
  final String status;

  AddRecommendError(this.status);

  @override
  List<Object?> get props => [status];
}

class SaveButtonState extends AddRecommendState {
  final bool isContinue;

  SaveButtonState(this.isContinue);

  @override
  List<Object?> get props => [isContinue];
}

class ChangeTagState extends AddRecommendState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ChangeWeatherState extends AddRecommendState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}
