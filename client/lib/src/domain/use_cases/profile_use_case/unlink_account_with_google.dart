import 'package:coffee/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../repositories/profile_repository.dart';

@lazySingleton
class UnlinkAccountWithGoogleUseCase extends UseCase<DataState, dynamic> {
  final ProfileRepository _repository;

  UnlinkAccountWithGoogleUseCase(this._repository);

  @override
  Future<DataState> call({params}) {
    return _repository.unlinkAccountWithGoogle();
  }
}
