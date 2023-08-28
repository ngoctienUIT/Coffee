import 'package:coffee/src/core/use_cases/use_case.dart';
import 'package:coffee/src/domain/repositories/login_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../core/request/login_request/login_email_password_request.dart';
import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/login/login_response.dart';

@lazySingleton
class LoginEmailPasswordUseCase
    extends UseCase<DataState<LoginResponse>, LoginEmailPasswordRequest> {
  LoginEmailPasswordUseCase(this._loginRepository);

  final LoginRepository _loginRepository;

  @override
  Future<DataState<LoginResponse>> call(
      {required LoginEmailPasswordRequest params}) {
    return _loginRepository.loginWithEmailPassword(params);
  }
}
