import '../../../data/models/topping.dart';

abstract class AddToppingEvent {}

class CreateToppingEvent extends AddToppingEvent {
  Topping topping;

  CreateToppingEvent(this.topping);
}

class ChangeImageEvent extends AddToppingEvent {
  String image;

  ChangeImageEvent(this.image);
}

class SaveButtonEvent extends AddToppingEvent {
  bool isContinue;

  SaveButtonEvent(this.isContinue);
}

class UpdateToppingEvent extends AddToppingEvent {
  Topping topping;

  UpdateToppingEvent(this.topping);
}
