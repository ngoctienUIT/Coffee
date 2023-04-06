import '../../../data/models/tag.dart';

abstract class AddTagEvent {}

class CreateTagEvent extends AddTagEvent {
  Tag tag;

  CreateTagEvent(this.tag);
}

class SaveButtonEvent extends AddTagEvent {
  bool isContinue;

  SaveButtonEvent(this.isContinue);
}

class UpdateTagEvent extends AddTagEvent {
  Tag tag;

  UpdateTagEvent(this.tag);
}
