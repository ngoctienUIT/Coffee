import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/topping/topping_response.dart';
import '../../repositories/topping_repository.dart';

@lazySingleton
class DeleteToppingUseCase extends UseCase<DataState<ToppingResponse>, String> {
  final ToppingRepository _repository;

  DeleteToppingUseCase(this._repository);

  @override
  Future<DataState<ToppingResponse>> call({required String params}) {
    return _repository.deleteTopping(params);
  }
}
