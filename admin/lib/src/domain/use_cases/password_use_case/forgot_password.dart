import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../repositories/password_repository.dart';

@lazySingleton
class ForgotPasswordUseCase extends UseCase<DataState<String>, String> {
  final PasswordRepository _repository;

  ForgotPasswordUseCase(this._repository);

  @override
  Future<DataState<String>> call({required String params}) {
    return _repository.forgotPassword(params);
  }
}
