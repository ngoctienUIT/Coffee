import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../repositories/setting_repository.dart';

@lazySingleton
class DeleteAccountUseCase extends UseCase<DataState, dynamic> {
  final SettingRepository _repository;

  DeleteAccountUseCase(this._repository);

  @override
  Future<DataState> call({params}) {
    return _repository.deleteAccount();
  }
}
