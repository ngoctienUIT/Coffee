import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:coffee_admin/src/data/models/user.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/user/user_response.dart';
import '../../repositories/password_repository.dart';

@lazySingleton
class ChangePasswordUseCase extends UseCase<DataState<UserResponse>, User> {
  final PasswordRepository _repository;

  ChangePasswordUseCase(this._repository);

  @override
  Future<DataState<UserResponse>> call({required User params}) {
    return _repository.changePassword(params);
  }
}
