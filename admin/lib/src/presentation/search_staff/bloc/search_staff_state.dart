import 'package:coffee_admin/src/domain/entities/user/user_response.dart';

abstract class SearchStaffState {}

class InitState extends SearchStaffState {}

class SearchLoading extends SearchStaffState {}

class SearchLoaded extends SearchStaffState {
  final List<UserResponse> listUser;

  SearchLoaded(this.listUser);
}

class SearchError extends SearchStaffState {
  final String? message;

  SearchError(this.message);
}
