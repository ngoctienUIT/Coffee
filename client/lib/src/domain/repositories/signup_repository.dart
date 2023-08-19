import '../../core/request/signup_request/signup_email_password_request.dart';
import '../../core/resources/data_state.dart';
import '../../data/remote/response/user/user_response.dart';

abstract class SignupRepository {
  Future<DataState<UserResponse>> signupWithEmailPassword(
      SignupEmailPasswordRequest request);
}
