import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/user/user_response.dart';
import '../../repositories/search_repository.dart';

@lazySingleton
class SearchStaffUseCase
    extends UseCase<DataState<List<UserResponse>>, String> {
  final SearchRepository _repository;

  SearchStaffUseCase(this._repository);

  @override
  Future<DataState<List<UserResponse>>> call({required String params}) {
    return _repository.searchStaff(params);
  }
}
