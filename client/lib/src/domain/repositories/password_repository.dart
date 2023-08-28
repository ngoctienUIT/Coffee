import '../../core/request/input_pin_request/input_pin_request.dart';
import '../../core/request/new_password_request/new_password_request.dart';
import '../../core/resources/data_state.dart';
import '../../data/models/user.dart';
import '../../data/remote/response/user/user_response.dart';

abstract class PasswordRepository {
  Future<DataState<UserResponse>> changePassword(User user);

  Future<DataState<String>> forgotPassword(String email);

  Future<DataState<UserResponse>> createNewPassword(NewPasswordRequest request);

  Future<DataState<bool>> inputPin(InputPinRequest request);
}
