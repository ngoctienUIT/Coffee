import 'package:coffee_admin/src/core/resources/data_state.dart';

import '../../data/models/user.dart';
import '../../data/remote/response/user/user_response.dart';

abstract class SignUpRepository {
  Future<DataState<UserResponse>> signUpWithEmailPassword(User user);
}
