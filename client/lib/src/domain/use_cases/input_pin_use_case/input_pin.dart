import 'package:coffee/src/core/request/input_pin_request/input_pin_request.dart';
import 'package:coffee/src/core/resources/data_state.dart';
import 'package:coffee/src/core/use_cases/use_case.dart';
import 'package:coffee/src/domain/repositories/input_pin_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class InputPinUseCase extends UseCase<DataState<bool>, InputPinRequest> {
  InputPinUseCase(this._repository);

  final InputPinRepository _repository;

  @override
  Future<DataState<bool>> call({required InputPinRequest params}) {
    return _repository.sendApi(params);
  }
}
