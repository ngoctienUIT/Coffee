import 'package:equatable/equatable.dart';

import '../../../data/models/tag.dart';

abstract class AddTagEvent extends Equatable {}

class CreateTagEvent extends AddTagEvent {
  final Tag tag;

  CreateTagEvent(this.tag);

  @override
  List<Object?> get props => [tag];
}

class SaveButtonEvent extends AddTagEvent {
  final bool isContinue;

  SaveButtonEvent(this.isContinue);

  @override
  List<Object?> get props => [isContinue];
}

class ChangeColorEvent extends AddTagEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class UpdateTagEvent extends AddTagEvent {
  final Tag tag;

  UpdateTagEvent(this.tag);

  @override
  List<Object?> get props => [tag];
}
