import 'package:coffee_admin/src/domain/entities/user/user_response.dart';

abstract class AccountState {}

class InitState extends AccountState {}

class AccountLoading extends AccountState {}

class AccountLoaded extends AccountState {
  final int index;
  final List<UserResponse> listAccount;

  AccountLoaded(this.index, this.listAccount);
}

class AccountError extends AccountState {
  final String? message;

  AccountError(this.message);
}
