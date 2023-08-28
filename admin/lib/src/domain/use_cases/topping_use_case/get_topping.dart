import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/topping/topping_response.dart';
import '../../repositories/topping_repository.dart';

@lazySingleton
class GetToppingUseCase
    extends UseCase<DataState<List<ToppingResponse>>, dynamic> {
  final ToppingRepository _repository;

  GetToppingUseCase(this._repository);

  @override
  Future<DataState<List<ToppingResponse>>> call({params}) {
    return _repository.getTopping();
  }
}
