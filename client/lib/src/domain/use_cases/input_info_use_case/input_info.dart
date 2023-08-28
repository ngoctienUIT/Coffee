import 'package:coffee/src/domain/repositories/input_info_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../core/request/input_info_request/input_info_request.dart';
import '../../../core/resources/data_state.dart';
import '../../../core/use_cases/use_case.dart';

@lazySingleton
class InputInfoUseCase extends UseCase<DataState<dynamic>, InputInfoRequest> {
  InputInfoUseCase(this._repository);

  final InputInfoRepository _repository;

  @override
  Future<DataState<dynamic>> call({required InputInfoRequest params}) {
    return _repository.submitInfo(params);
  }
}
