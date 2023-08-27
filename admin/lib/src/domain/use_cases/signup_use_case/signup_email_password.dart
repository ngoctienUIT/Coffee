import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:coffee_admin/src/data/models/user.dart';
import 'package:coffee_admin/src/data/remote/response/user/user_response.dart';
import 'package:injectable/injectable.dart';

import '../../repositories/signup_repository.dart';

@lazySingleton
class SignUpEmailPasswordUseCase
    extends UseCase<DataState<UserResponse>, User> {
  final SignUpRepository _repository;

  SignUpEmailPasswordUseCase(this._repository);

  @override
  Future<DataState<UserResponse>> call({required User params}) {
    return _repository.signUpWithEmailPassword(params);
  }
}
