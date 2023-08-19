import 'package:coffee/src/core/resources/data_state.dart';

import '../../core/request/login_request/login_email_password_request.dart';
import '../../core/request/login_request/login_google_request.dart';
import '../../data/remote/response/login/login_response.dart';

abstract class LoginRepository {
  Future<DataState<LoginResponse>> loginWithEmailPassword(
      LoginEmailPasswordRequest request);

  Future<DataState<LoginResponse>> loginWithGoogle(LoginGoogleRequest request);
}
