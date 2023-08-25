import 'package:coffee_admin/src/core/request/topping_request/topping_request.dart';
import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/topping/topping_response.dart';
import '../../repositories/topping_repository.dart';

@lazySingleton
class CreateToppingUseCase
    extends UseCase<DataState<ToppingResponse>, ToppingRequest> {
  final ToppingRepository _repository;

  CreateToppingUseCase(this._repository);

  @override
  Future<DataState<ToppingResponse>> call({required ToppingRequest params}) {
    return _repository.createTopping(params);
  }
}
