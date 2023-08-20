import 'package:coffee/src/core/resources/data_state.dart';

import '../../data/models/user.dart';
import '../../data/remote/response/user/user_response.dart';

abstract class ChangePasswordRepository {
  Future<DataState<UserResponse>> changePassword(User user);
}