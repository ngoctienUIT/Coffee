import 'package:coffee/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../data/models/user.dart';
import '../../repositories/profile_repository.dart';

@lazySingleton
class DeleteAvatarUseCase extends UseCase<DataState<User>, User> {
  final ProfileRepository _repository;

  DeleteAvatarUseCase(this._repository);

  @override
  Future<DataState<User>> call({required User params}) {
    return _repository.deleteAvatar(params);
  }
}
