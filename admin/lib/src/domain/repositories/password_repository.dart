import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:coffee_admin/src/data/models/user.dart';
import 'package:coffee_admin/src/data/remote/response/user/user_response.dart';

import '../../core/request/password_request/input_pin_request.dart';
import '../../core/request/password_request/new_password_request.dart';

abstract class PasswordRepository {
  Future<DataState<UserResponse>> changePassword(User user);

  Future<DataState<String>> forgotPassword(String email);

  Future<DataState<UserResponse>> createNewPassword(NewPasswordRequest request);

  Future<DataState<bool>> inputPin(InputPinRequest request);
}
