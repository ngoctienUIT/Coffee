import 'package:coffee/src/data/remote/response/user/user_response.dart';
import 'package:coffee/src/domain/repositories/signup_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../core/request/signup_request/signup_email_password_request.dart';
import '../../../core/resources/data_state.dart';
import '../../../core/use_cases/use_case.dart';

@injectable
class SignupEmailPasswordUseCase
    extends UseCase<DataState<UserResponse>, SignupEmailPasswordRequest> {
  SignupEmailPasswordUseCase(this._repository);

  final SignupRepository _repository;

  @override
  Future<DataState<UserResponse>> call(
      {required SignupEmailPasswordRequest params}) async {
    return _repository.signupWithEmailPassword(params);
  }
}
