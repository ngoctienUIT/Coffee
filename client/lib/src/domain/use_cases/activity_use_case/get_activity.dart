import 'package:coffee/src/core/use_cases/use_case.dart';
import 'package:coffee/src/domain/repositories/activity_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/order/order_response.dart';

@lazySingleton
class GetActivityUseCase extends UseCase<DataState<List<OrderResponse>>, int> {
  GetActivityUseCase(this._repository);

  final ActivityRepository _repository;

  @override
  Future<DataState<List<OrderResponse>>> call({required int params}) {
    return _repository.getData(params);
  }
}
