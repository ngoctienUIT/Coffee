import '../../../data/models/store.dart';

abstract class AddStoreEvent {}

class CreateStoreEvent extends AddStoreEvent {
  Store store;

  CreateStoreEvent(this.store);
}

class ChangeImageEvent extends AddStoreEvent {
  String image;

  ChangeImageEvent(this.image);
}

class SaveButtonEvent extends AddStoreEvent {
  bool isContinue;

  SaveButtonEvent(this.isContinue);
}

class UpdateStoreEvent extends AddStoreEvent {
  Store store;

  UpdateStoreEvent(this.store);
}

class ChangeAddressEvent extends AddStoreEvent {}

class ChangeOpenEvent extends AddStoreEvent {}

class ChangeCloseEvent extends AddStoreEvent {}
