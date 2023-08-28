import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/request/password_request/new_password_request.dart';
import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/user/user_response.dart';
import '../../repositories/password_repository.dart';

@lazySingleton
class CreateNewPasswordUseCase
    extends UseCase<DataState<UserResponse>, NewPasswordRequest> {
  final PasswordRepository _repository;

  CreateNewPasswordUseCase(this._repository);

  @override
  Future<DataState<UserResponse>> call({required NewPasswordRequest params}) {
    return _repository.createNewPassword(params);
  }
}
