import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/login/login_response.dart';
import '../../../presentation/login/bloc/login_event.dart';
import '../../repositories/login_repository.dart';

@lazySingleton
class LoginEmailPasswordUseCase
    extends UseCase<DataState<LoginResponse>, LoginWithEmailPasswordEvent> {
  final LoginRepository _repository;

  LoginEmailPasswordUseCase(this._repository);

  @override
  Future<DataState<LoginResponse>> call(
      {required LoginWithEmailPasswordEvent params}) {
    return _repository.loginWithEmailPassword(params);
  }
}
