import 'package:coffee/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/request/profile_request/save_profile_request.dart';
import '../../../core/resources/data_state.dart';
import '../../../data/models/user.dart';
import '../../repositories/profile_repository.dart';

@lazySingleton
class SaveProfileUseCase extends UseCase<DataState<User>, SaveProfileRequest> {
  final ProfileRepository _repository;

  SaveProfileUseCase(this._repository);

  @override
  Future<DataState<User>> call({required SaveProfileRequest params}) {
    return _repository.saveProfile(params);
  }
}
