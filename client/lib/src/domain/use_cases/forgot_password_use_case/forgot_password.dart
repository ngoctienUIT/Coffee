import 'package:coffee/src/core/resources/data_state.dart';
import 'package:coffee/src/core/use_cases/use_case.dart';
import 'package:coffee/src/domain/repositories/forgot_password_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ForgotPasswordUseCase extends UseCase<DataState<String>, String> {
  ForgotPasswordUseCase(this._repository);

  final ForgotPasswordRepository _repository;

  @override
  Future<DataState<String>> call({required String params}) {
    return _repository.sendEmail(params);
  }
}
