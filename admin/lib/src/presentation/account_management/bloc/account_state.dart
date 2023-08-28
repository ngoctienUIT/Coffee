import 'package:equatable/equatable.dart';

import '../../../data/remote/response/user/user_response.dart';

abstract class AccountState extends Equatable {}

class InitState extends AccountState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class AccountLoading extends AccountState {
  final bool check;

  AccountLoading([this.check = true]);

  @override
  List<Object?> get props => [identityHashCode(this)];
}

class AccountLoaded extends AccountState {
  final int index;
  final List<UserResponse> listAccount;
  final bool check;

  AccountLoaded(this.index, this.listAccount, [this.check = true]);

  @override
  List<Object?> get props => [index, listAccount, check];
}

class AccountError extends AccountState {
  final String? message;

  AccountError(this.message);

  @override
  List<Object?> get props => [message];
}
