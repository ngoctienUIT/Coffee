import 'package:coffee_admin/src/core/request/password_request/input_pin_request.dart';
import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../repositories/password_repository.dart';

@lazySingleton
class InputPinUseCase extends UseCase<DataState<bool>, InputPinRequest> {
  final PasswordRepository _repository;

  InputPinUseCase(this._repository);

  @override
  Future<DataState<bool>> call({required InputPinRequest params}) {
    return _repository.inputPin(params);
  }
}
