import 'package:coffee_admin/src/domain/entities/user/user_response.dart';

abstract class AccountState {}

class InitState extends AccountState {}

class AccountLoading extends AccountState {
  bool check;

  AccountLoading([this.check = true]);
}

class AccountLoaded extends AccountState {
  final int index;
  final List<UserResponse> listAccount;
  final bool check;

  AccountLoaded(this.index, this.listAccount, [this.check = true]);
}

class AccountError extends AccountState {
  final String? message;

  AccountError(this.message);
}
