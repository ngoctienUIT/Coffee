import 'package:coffee_admin/src/core/resources/data_state.dart';

import '../../data/remote/response/login/login_response.dart';
import '../../presentation/login/bloc/login_event.dart';

abstract class LoginRepository {
  Future<DataState<LoginResponse>> loginWithEmailPassword(
      LoginWithEmailPasswordEvent event);
}
