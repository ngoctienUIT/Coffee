import 'package:coffee/src/core/resources/data_state.dart';

import '../../core/request/new_password_request/new_password_request.dart';
import '../../data/remote/response/user/user_response.dart';

abstract class NewPasswordRepository {
  Future<DataState<UserResponse>> sendApi(NewPasswordRequest request);
}
