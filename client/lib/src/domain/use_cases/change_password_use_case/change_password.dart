import 'package:coffee/src/core/use_cases/use_case.dart';
import 'package:coffee/src/data/models/user.dart';
import 'package:coffee/src/domain/repositories/change_password_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/user/user_response.dart';

@lazySingleton
class ChangePasswordUseCase extends UseCase<DataState<UserResponse>, User> {
  ChangePasswordUseCase(this._repository);

  final ChangePasswordRepository _repository;

  @override
  Future<DataState<UserResponse>> call({required User params}) {
    return _repository.changePassword(params);
  }
}
