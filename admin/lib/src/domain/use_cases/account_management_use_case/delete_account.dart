import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../repositories/account_management_repository.dart';

@lazySingleton
class DeleteAccountUseCase extends UseCase<DataState, String> {
  final AccountManagementRepository _repository;

  DeleteAccountUseCase(this._repository);

  @override
  Future<DataState> call({required String params}) {
    return _repository.deleteAccount(params);
  }
}
