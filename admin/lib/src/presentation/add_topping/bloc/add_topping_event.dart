import 'package:equatable/equatable.dart';

import '../../../data/models/topping.dart';

abstract class AddToppingEvent extends Equatable {}

class CreateToppingEvent extends AddToppingEvent {
  final Topping topping;

  CreateToppingEvent(this.topping);

  @override
  List<Object?> get props => [topping];
}

class ChangeImageEvent extends AddToppingEvent {
  final String image;

  ChangeImageEvent(this.image);

  @override
  List<Object?> get props => [image];
}

class SaveButtonEvent extends AddToppingEvent {
  final bool isContinue;

  SaveButtonEvent(this.isContinue);

  @override
  List<Object?> get props => [isContinue];
}

class UpdateToppingEvent extends AddToppingEvent {
  final Topping topping;

  UpdateToppingEvent(this.topping);

  @override
  List<Object?> get props => [topping];
}
