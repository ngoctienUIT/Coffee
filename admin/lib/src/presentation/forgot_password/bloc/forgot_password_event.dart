import 'package:equatable/equatable.dart';

abstract class ForgotPasswordEvent extends Equatable {}

class ShowButtonEvent extends ForgotPasswordEvent {
  final bool isContinue;

  ShowButtonEvent(this.isContinue);

  @override
  List<Object?> get props => [isContinue];
}

class SendForgotPasswordEvent extends ForgotPasswordEvent {
  final String email;

  SendForgotPasswordEvent(this.email);

  @override
  List<Object?> get props => [email];
}
