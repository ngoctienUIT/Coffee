import 'package:injectable/injectable.dart';

import '../../../core/request/input_pin_request/input_pin_request.dart';
import '../../../core/resources/data_state.dart';
import '../../../core/use_cases/use_case.dart';
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
