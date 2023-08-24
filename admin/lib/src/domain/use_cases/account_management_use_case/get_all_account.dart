import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:coffee_admin/src/domain/repositories/account_management_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../data/remote/response/user/user_response.dart';

@lazySingleton
class GetAllAccountUseCase
    extends UseCase<DataState<List<UserResponse>>, dynamic> {
  final AccountManagementRepository _repository;

  GetAllAccountUseCase(this._repository);

  @override
  Future<DataState<List<UserResponse>>> call({params}) {
    return _repository.getAllAccount();
  }
}
