import 'package:equatable/equatable.dart';

import '../../../data/remote/response/user/user_response.dart';

abstract class SearchStaffState extends Equatable {}

class InitState extends SearchStaffState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class SearchLoading extends SearchStaffState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class SearchLoaded extends SearchStaffState {
  final List<UserResponse> listUser;

  SearchLoaded(this.listUser);

  @override
  List<Object?> get props => [listUser];
}

class SearchError extends SearchStaffState {
  final String? message;

  SearchError(this.message);

  @override
  List<Object?> get props => [message];
}
