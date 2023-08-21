import 'package:coffee/src/core/use_cases/use_case.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../repositories/profile_repository.dart';

@lazySingleton
class LinkAccountWithGoogleUseCase
    extends UseCase<DataState, GoogleSignInAccount> {
  final ProfileRepository _repository;

  LinkAccountWithGoogleUseCase(this._repository);

  @override
  Future<DataState> call({required GoogleSignInAccount params}) {
    return _repository.linkAccountWithGoogle(params);
  }
}
