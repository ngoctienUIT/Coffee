import 'package:equatable/equatable.dart';

abstract class AddTagState extends Equatable {}

class InitState extends AddTagState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class SaveButtonState extends AddTagState {
  final bool isContinue;

  SaveButtonState(this.isContinue);

  @override
  List<Object?> get props => [isContinue];
}

class AddTagLoadingState extends AddTagState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class AddTagSuccessState extends AddTagState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class AddTagErrorState extends AddTagState {
  final String status;

  AddTagErrorState(this.status);

  @override
  List<Object?> get props => [status];
}

class ChangeColorState extends AddTagState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}
