import 'package:coffee/src/core/request/new_password_request/new_password_request.dart';
import 'package:coffee/src/core/resources/data_state.dart';
import 'package:coffee/src/core/use_cases/use_case.dart';
import 'package:coffee/src/data/remote/response/user/user_response.dart';
import 'package:coffee/src/domain/repositories/new_password_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NewPasswordUseCase
    extends UseCase<DataState<UserResponse>, NewPasswordRequest> {
  NewPasswordUseCase(this._repository);

  final NewPasswordRepository _repository;

  @override
  Future<DataState<UserResponse>> call({required NewPasswordRequest params}) {
    return _repository.sendApi(params);
  }
}
