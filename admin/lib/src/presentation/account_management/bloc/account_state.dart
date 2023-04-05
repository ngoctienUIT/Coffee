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

class RefreshLoading extends AccountState {}

class RefreshLoaded extends AccountState {
  final int index;
  final List<UserResponse> listAccount;

  RefreshLoaded(this.index, this.listAccount);
}

class RefreshError extends AccountState {
  final String? message;
  RefreshError(this.message);
}
