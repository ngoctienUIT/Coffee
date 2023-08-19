import '../../../core/request/login_request/login_google_request.dart';
import '../../../core/resources/data_state.dart';
import '../../../core/use_cases/use_case.dart';
import '../../../data/remote/response/login/login_response.dart';
import '../../repositories/login_repository.dart';

class LoginGoogleUseCase
    extends UseCase<DataState<LoginResponse>, LoginGoogleRequest> {
  LoginGoogleUseCase(this._loginRepository);

  final LoginRepository _loginRepository;

  @override
  Future<DataState<LoginResponse>> call({required LoginGoogleRequest params}) {
    return _loginRepository.loginWithGoogle(params);
  }
}
